To infer embeddings based on **cluster density** without AI/ML frameworks, we can use graph theory and linear algebra to weight terms by their prominence in dense clusters. Below is a composable pipeline using Julia scripts, intermediate files, and explicit mathematical steps.

---

### **Pipeline Design**
1. **Cluster Documents + Compute Density**  
   Identify dense clusters in a document similarity graph.  
2. **Map Terms to Cluster Density**  
   Calculate how prominently terms appear in dense clusters.  
3. **Density-Adjusted TF-IDF Embeddings**  
   Weight terms by their association with dense clusters.

---

### **1. Cluster Documents & Compute Density**  
*Input*: TF-IDF vectors (from prior step)  
*Output*: TSV of `cluster_id density document1,document2,...`

```julia
# cluster_density.jl
using LinearAlgebra, SparseArrays

# Read TF-IDF vectors into a matrix (rows=documents, cols=terms)
docs = [...]  # Load from prior step
similarity_matrix = docs * docs'  # Cosine similarity (simplified)

# Threshold to create adjacency matrix
threshold = 0.2
adjacency = similarity_matrix .> threshold

# Find dense clusters via k-core decomposition
function k_core_adjacency(adj, k=3)
    while true
        degrees = sum(adj, dims=2)
        to_remove = degrees .< k
        isempty(to_remove) && break
        adj = adj[.!to_remove, .!to_remove]
    end
    return adj
end

dense_subgraph = k_core_adjacency(adjacency)

# Compute density: edges / max_possible_edges
n = size(dense_subgraph, 1)
density = sum(dense_subgraph) / (n * (n-1))

# Output cluster ID, density, and member documents
println(join([1, density, join(document_ids, ",")], '\t'))
```

**Math**:  
- **Density**:  
  `\text{Density}(C) = \frac{\text{Edges in } C}{\binom{|C|}{2}}`  
- **k-Core**: Retain nodes with degree ≥ `k` iteratively.

---

### **2. Term-to-Cluster Density Mapping**  
*Input*: Clusters (from step 1) + Term counts (from prior)  
*Output*: TSV `term avg_cluster_density`

```julia
# term_density.jl
clusters = Dict{Int, Tuple{Float64, Vector{String}}}()
open("clusters.tsv") do f
    for line in eachline(f)
        id, density, docs = split(line, '\t')
        clusters[parse(Int, id)] = (parse(Float64, density), split(docs, ","))
    end
end

term_density = Dict{String, Vector{Float64}}()
open("term_counts.tsv") do f
    for line in eachline(f)
        doc, term, _ = split(line, '\t')
        for (cluster_id, (density, members)) in clusters
            if doc in members
                push!(get!(term_density, term, []), density)
            end
        end
    end
end

# Output average density per term
for (term, densities) in term_density
    avg = isempty(densities) ? 0.0 : sum(densities) / length(densities)
    println(join([term, avg], '\t'))
end
```

**Math**:  
`\text{AvgDensity}(t) = \frac{1}{|C_t|} \sum_{C \in C_t} \text{Density}(C)`  
where `C_t` = clusters where term `t` appears.

---

### **3. Density-Adjusted Embeddings**  
*Input*: Term densities (step 2) + TF-IDF (prior)  
*Output*: Embeddings `document_id embedding_vector`

```julia
# density_embeddings.jl
using LinearAlgebra

# Load term density scores
term_scores = Dict{String, Float64}()
open("term_density.tsv") do f
    for line in eachline(f)
        term, score = split(line, '\t')
        term_scores[term] = parse(Float64, score)
    end
end

# Load TF-IDF and adjust by density
open("tfidf.tsv") do f
    for line in eachline(f)
        doc, term, tfidf = split(line, '\t')
        adjusted = parse(Float64, tfidf) * (1 + term_scores[term])
        # ... accumulate into document embedding ...
    end
end

# Output document vectors
for doc in documents
    println(join([doc.id, join(doc.embedding, ",")], '\t'))
end
```

**Math**:  
`\text{Embedding}(d)_t = \text{TF-IDF}(t,d) \times (1 + \text{AvgDensity}(t))`

---

### **Usage**

```bash
# 1. Cluster documents
julia cluster_density.jl < tfidf_vectors.tsv > clusters.tsv

# 2. Map terms to cluster density
julia term_density.jl clusters.tsv term_counts.tsv > term_density.tsv

# 3. Compute final embeddings
julia density_embeddings.jl term_density.tsv tfidf.tsv > embeddings.tsv
```

---

### **Key Advantages**
1. **Composability**: Each script handles one task, using TSV intermediates.  
2. **Cluster-Driven Embeddings**: Terms in dense clusters get amplified.  
3. **Transparency**: No black-box models—adjust weights via term scores.  

For example, a term like "cognitive" appearing in a cluster with density `0.8` would have its TF-IDF multiplied by `1.8`, while a term in sparse clusters (`density=0.1`) would use `1.1`.

---

### **Example Output**
```
doc123    0.5,1.2,0.8,...  # Embedding with density-adjusted weights
```

This method surfaces terms that are **both frequent and contextually clustered**, mimicking how dense neural embeddings capture semantic proximity.
