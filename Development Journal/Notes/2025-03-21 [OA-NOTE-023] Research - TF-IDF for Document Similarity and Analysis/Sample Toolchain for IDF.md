# Universal Note Analysis Toolkit (Julia/Rust)
*Pure stream processing with time-aware TF-IDF and similarity*

## 1. Find Relevant Files (Bash)
**Input**: List of root directories via stdin  
**Output**: TSV `mtime path`

```bash
#!/bin/bash
# find_files.sh
while read dir; do
  find "$dir" -type f -mtime -1825 -exec file {} \; | \
    grep -iP 'text|ascii' | cut -d: -f1 | xargs stat -c "%Y\t%n"
done
```

**Math**:

>   `$$ \text{age}(f)_{\text{days}} = \frac{\text{now} - \text{mtime}(f)}{86400}% $$`

---

## 2. Extract Terms with Time (Bash → TSV)
**Input**: TSV from `find_files.sh`  
**Output**: TSV `path mtime term count`

```bash
# extract.sh
while IFS=$'\t' read -r mtime path; do
  rg -o --no-filename -w '\w{3,}' "$path" | tr '[:upper:]' '[:lower:]' | \
    sort | uniq -c | \
    awk -v path="$path" -v mtime="$mtime" \
    '{print path, mtime, $2, $1}' | tr ' ' '\t'
done
```

---

## 3. Time-Weighted TF-IDF (Julia)
**Input**: TSV from `extract.sh`  
**Output**: TSV `path term tfidf`

```julia
# tfidf.jl
using Dates, LinearAlgebra

struct DocData
  path::String
  mtime::Float64
  terms::Dict{String,Float64}
end

docs = DocData[]
idf = Dict{String,Float64}()

# Read all data first (for IDF calculation)
for line in eachline(stdin)
  parts = split(line, '\t')
  path, mtime, term, count = parts[1], parse(Float64, parts[2]), parts[3], parse(Int, parts[4])
  
  # Find or create document
  doc = findfirst(d -> d.path == path, docs)
  if isnothing(doc)
    push!(docs, DocData(path, mtime, Dict{String,Float64}()))
    doc = lastindex(docs)
  end
  
  # Time-weighted TF (customizable)
  age_days = (now() - unix2datetime(mtime)) / Day(1)
  docs[doc].terms[term] = get(docs[doc].terms, term, 0.0) + count * (1 + log1p(age_days))
end

# Compute IDF
N = length(docs)
for term in union([keys(d.terms) for d in docs]...)
  df = sum(haskey(d.terms, term) for d in docs)
  idf[term] = log(N / (1 + df))
end

# Output TF-IDF
for d in docs
  norm = norm(collect(values(d.terms)))
  for (term, tf) in d.terms
    println(join([d.path, term, tf * idf[term] / norm], '\t'))
  end
end
```

**Math**:  

> `\text{TF}(t,d) = \text{count}(t,d) \times (1 + \ln(1 + \text{age}_{\text{days}}))`  

> `\text{IDF}(t) = \ln\left(\frac{N}{1 + \text{DF}(t)}\right)`  

> `\text{TF-IDF} = \frac{\text{TF} \times \text{IDF}}{\|\mathbf{d}\|_2}`

---

## 4. Similarity with Time Decay (Rust)
**Input**: TSV from `tfidf.jl`  
**Output**: TSV `path_a path_b similarity`

```rust
// similarity.rs
use std::collections::HashMap;
use std::io::{self, BufRead};

#[derive(Debug)]
struct Doc {
    terms: HashMap<String, f64>,
    mtime: i64,
}

fn main() {
    let mut docs = HashMap::new();
    
    // Read TF-IDF data
    for line in io::stdin().lock().lines() {
        let line = line.unwrap();
        let parts: Vec<_> = line.split('\t').collect();
        let (path, term, score) = (&parts[0], &parts[1], parts[2].parse::<f64>().unwrap());
        
        docs.entry(path.clone())
            .or_insert(Doc { terms: HashMap::new(), mtime: 0 })
            .terms.insert(term.clone(), score);
    }

    // Compare all pairs
    let paths: Vec<_> = docs.keys().collect();
    for i in 0..paths.len() {
        for j in (i+1)..paths.len() {
            let a = &docs[paths[i]];
            let b = &docs[paths[j]];
            
            // Cosine similarity
            let dot_product: f64 = a.terms.iter()
                .filter_map(|(k, v)| b.terms.get(k).map(|w| v * w))
                .sum();
            
            let norm_a = a.terms.values().map(|v| v.powi(2)).sum::<f64>().sqrt();
            let norm_b = b.terms.values().map(|v| v.powi(2)).sum::<f64>().sqrt();
            let content_sim = dot_product / (norm_a * norm_b);

            // Time similarity (exponential decay)
            let time_diff = (a.mtime - b.mtime).abs() as f64 / 31_536_000.0; // Diff in years
            let time_sim = (-time_diff).exp();
            
            let total_sim = 0.7 * content_sim + 0.3 * time_sim;
            println!("{}\t{}\t{:.4}", paths[i], paths[j], total_sim);
        }
    }
}
```

**Math**:  
`\text{sim}(A,B) = 0.7 \times \cos(\mathbf{A},\mathbf{B}) + 0.3 \times e^{-|\text{age}(A) - \text{age}(B)|}`

---

## Usage Pipeline

```bash
# Full pipeline
cat directories.txt | ./find_files.sh | ./extract.sh | \
  julia tfidf.jl | ./similarity | sort -t$'\t' -k3 -nr

# Extract specific components
awk -F'\t' -v target="notes/emotion.md" '
  $1 == target {print $2, $3}' tfidf.tsv | sort -k2 -nr
```

---

## Key Features

1. **Time Blending**  
   Modify the similarity weights in `similarity.rs`:
   ```rust
   let total_sim = 0.5 * content_sim + 0.5 * time_sim;  // More time-sensitive
   ```

2. **Term Differences**  
   Find distinguishing terms between two docs:
   ```bash
   awk -F'\t' -v a="path1" -v b="path2" '
     $1 == a { terms_a[$2] = $3 }
     $1 == b { terms_b[$2] = $3 }
     END {
       for (t in terms_a) {
         diff = terms_a[t] - (t in terms_b ? terms_b[t] : 0)
         print t, diff
       }
     }' tfidf.tsv | sort -k2 -nr
   ```

3. **Algorithm Switching**  
   Change TF weighting in `tfidf.jl`:
   ```julia
   # Exponential time weighting (recent focus)
   tf = count * exp(-age_days / 365)  # Instead of log1p
   ```

---

## Script Extraction

```bash
# Generate all components from this markdown
sed -n '/^```bash$/,/^```$/ { /^```/d; p }' note_analysis.md > find_files.sh
sed -n '/^```julia$/,/^```$/ { /^```/d; p }' note_analysis.md > tfidf.jl
sed -n '/^```rust$/,/^```$/ { /^```/d; p }' note_analysis.md > src/main.rs

# Build Rust similarity tool
cargo build --release && mv target/release/similarity .
```


**To Use**:

1. Save as `note_analysis.md`

2. Extract scripts: `awk '/^```(bash|julia|rust)$/{f=1;next} /^```$/{f=0} f' note_analysis.md > components.sh`

3. Pipe through components as shown in Usage Pipeline
