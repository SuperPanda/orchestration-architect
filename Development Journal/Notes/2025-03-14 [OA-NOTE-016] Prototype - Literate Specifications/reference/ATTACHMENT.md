
--------------------ATTACHMENTS--------------------

I will consider using tools built around rust but I need to know what to do to bootstrap via SHELL scripts first,
initial morphism and all that.

Will probably build with rust, but in a manner that facilitates deriving using shell.

```
2025-03-14 [OA-NOTE-011] Research - Analysis on direction of resource resolvers development/README.md

>   **REQUIREMENT**: Generate tasks files.
>   **REQUIREMENT**: Rebuild the Terminal AI in rust, and allow it to call functions that is able to automatically fetch relevant snippets and data from the semantic web. Allow for it to recommend improving the ontology, and querying the existing structures. And allow it to improve tasks. Make it use tf-idf tool to find things, which have the page rank on requirements, and see if we can beat make batch embedding training and distilling redundant. We can use regex to match patterns and we can see what is around it.
>   **REQUIREMENT**: Need to make grammar and file matching protocols. A distributed vocab that is composed when different elements come together. Needs to be all text based.
>   **REQUIREMENT**: All requirements when processed become tasks. Will need to finsih requirements.
>   **REQUIREMENT**: When semantic naming collides, I think that we can use a pre-order to resolve, and use OA-NOTE-010A.
>   **REQUIREMENT**: Generate D2Lang Specs that ensure that designs can easily generate and sync the semantic specs. Separate style, and content. Use the abstract composition topology concepts.
>   **REQUIREMENT**: Requirements that are similar can be made to be the same as the added requirements will be added to the requirement specs.
>   **REQUIREMENT**: [HIGH PRIORITY] Make it so the requirements and notes can be generated, and make it so that I can process a document easily with --interactive to just `sed s#>\W{3}\*\*REQUIREMENT\*\*#&#p` (or whatever grammer)
>   **IDEA**: Semantic Linking of Nodes in Natural Writing allow for ideas to elucidate. I need to explore my old tag scripts, to be able to map historic tasks.
>   **IDEA**: By restricting one topic to the dev journals it can form like an anchor of the certain kinds of tasks, then clustering things similar to it will allow me to add tags across the system, and to restructure the ontology.
>   **IDEA**: Use dates and other metadata to create an emotional (in the Minsky's abstract sense) to control which agents are working and responding, the analogous emotional thought process will be able to maybe focus the development, and provide feedback when processing the requirements and tasks. As requirements derive problems and goal -> needs -> requirements, the emotional states is a reflection of needs.
>   **IDEA**: Make it so I can map to things that are not available publically or within the system, by providing semantic context. These can be stored in the artifacts partition. 
>   **IDEA**: Maybe make the OA001 naming issue solved with a OA001_<ALPHABET> OA001_ALF etc. if remigrated OA001_BOB, I wonder what the solution space is, like if i made it so the date randomised the alphabetical name... OA001_CICI or something...
>   **IDEA**: Get the MOTD idea back and reimplement it with personality. Have it generate some personality test, and then generate a bunch that can change the vocab specs. 
>   **IDEA**: Negative Agent Reports on Outcomes and Normal Agent Reports on Outcomes, and a (+,-) benefit/cost game theory style thing. Actors/Strategies. Make an analogy to the game theory payoff matrix and make it decide based on some meta-construction of emotions from minkskys emotion machine (the bottom layer), and I need to fetch the higher layers that drive the architect. And the semantic structures will naturally grow like the good preorder tensor products of compositional systems it is. Not AGI, but something isomorphic. Like how conceptually relevant stuff is embedded in the natural of our language but we don't notice. I am about in the middle of the book and find that bit.
>   **IDEA**: Use natural writing and specifications that bootstrap the system but can be linked in a web (find the resource of Donald Knuth talking about that).
>   **REQUIREMENT**: Standardise the location of deployment files. Also make it so when a task is in the semantic network is changes **TASK** to **TASK-XXX** or **REQUIREMENT-XXX** perhaps using a timestamp in the metadata or something to resolve collisions using a consensus algorithm. Doesn't matter who has priority, as long as one does. Note the number of placeholders acts as an versioning epoch. This means that we can have like TASK-XXX be able to be redefined as TASK-XXX which locally might be relevant, but in a different domain might be mapped to identifier `oa:tasks:epic#SOMETHING` or have some way of generating dynamic actions when things change. Cascading the operations along. Like proving that a document has been checked off, and the review has been reviewed, etc. And triggering future meta_test, and then finally meta_release. 
>   **REQUIREMENT**: Need to create a tf-idf tool using aggrep or something, or a fuzzy finder to find similarly matched things, and maybe do a tf-idf page rank thing.
>   **REQUIREMENT**: Create a fuzzy finder semantic ranking match for LSP protocols.
>   **TASK**: Research how the git notes things works, and if i can store things in there like .oa-ignore something, or maybe add notes to identify what commit was added when and where :)
>   **Decision**:
```

```
/2025-03-13 [OA-NOTE-009] Prototype - Using Intermediate Representation for Semantic Renaming of Files/
├── FUTURE_WORK.md: Using rust with external definitions
├── REPORT.md: How PEST can be used
└── semantic-rename.sh: Semantic Script Experiment

1 directory, 5 files
```

Below is an explanation of how you can design a system whose behavior—and even what would normally be defined by Rust structs—is driven entirely by external specifications. In this model, you ship a single compiled binary that reads its grammar, tokens, and field definitions from configuration files at runtime. This means that even on a stripped‐down system (with no Rust toolchain installed), your binary can evolve and adapt simply by changing the specification file.

## How It Works

### External Specification File

Your entire system’s configuration (the “grammar”) is placed in an external file. For example, you could use a JSON, YAML, or even a custom DSL file that describes all the tokens, fields, and transformation rules. For example, a YAML spec might look like this:

```
# spec.yaml
file_name:
  pattern: "{date} [{identifier}] {label} - {name}{suffix}"
  tokens:
    date:
      regex: "\d{4}-\d{2}-\d{2}"
      description: "Date in YYYY-MM-DD format"
    identifier:
      regex: "OA-NOTE-\d{3}"
      description: "Identifier token"
    label:
      regex: "\w+"
      description: "Simple label"
    name:
      regex: "[^\.]+"
      description: "The file's name description"
    suffix:
      regex: "(\.[^$]*)?"
      description: "Optional suffix starting with a dot"
```

### Dynamic Grammar Loading and Processing

When your binary starts, it reads this specification file and dynamically builds its internal representation of the grammar. This structure replaces what you would otherwise define as Rust structs or enums at compile time.

For instance, you might have a data structure like this:

```rust
// main.rs
use serde::Deserialize;
use std::collections::HashMap;
use std::fs;

#[derive(Debug, Deserialize)]
struct GrammarSpec {
    file_name: FileNameSpec,
}

#[derive(Debug, Deserialize)]
struct FileNameSpec {
    pattern: String,
    tokens: HashMap<String, TokenSpec>,
}

#[derive(Debug, Deserialize)]
struct TokenSpec {
    regex: String,
    description: String,
}

fn main() {
    // Load the external specification
    let spec_content = fs::read_to_string("spec.yaml")
        .expect("Cannot read spec file");
    let grammar: GrammarSpec = serde_yaml::from_str(&spec_content)
        .expect("Invalid YAML syntax in spec file");

    // Now you have a grammar definition that can be used to construct
    // a parser dynamically. For instance, you might combine the regexes
    // for each token into one master regex.
    println!("Loaded grammar: {:#?}", grammar);

    // From the specification, build the master regex.
    // (In a full implementation, you’d substitute pattern keys with their regex.)
    let master_regex = build_master_regex(&grammar.file_name);
    println!("Master regex: {}", master_regex);

    // Process file names using the dynamically constructed regex, etc.
}

fn build_master_regex(spec: &FileNameSpec) -> String {
    // A dummy function that would replace tokens in the master pattern.
    let mut master = spec.pattern.clone();
    for (name, token) in &spec.tokens {
        // Replace {token_name} in the pattern with a capturing group.
        let placeholder = format!("{{{}}}", name);
        let capturing = format!("({})", token.regex);
        master = master.replace(&placeholder, &capturing);
    }
    // Note: You might want to escape literal characters in the pattern.
    master
}
```

In this design, the “struct-like” definitions aren’t hard-coded into your binary. Instead, they’re built at runtime from the spec file.

## Self-Contained Binary Without Rust on Target

Because the Rust code is only used to build the binary—and all the evolution happens via external configuration—the deployed binary is completely self-contained. End users (or a stripped-down system) only needs the binary and the spec file. No Rust toolchain is required at runtime. The binary:

>   Reads the spec file at startup.

>   Dynamically creates internal representations (e.g., a master regex) based on that data.

>   Uses that representation for tasks like parsing, transforming file names, updating tokens, etc.

## Interactivity and Evolution

The same design allows additional dynamic behavior. You could add interactive features (for example, using utilities like fzf) by querying the dynamic grammar data structure. If you want to update the identifier structure or add new tokens, you simply change the spec file and restart the binary. The system then "naturally evolves" without recompilation.

## Beyond Parsing: Generator and Translator

With the grammar available at runtime, you can also support other operations:

>   Parser: Dynamically parse file names or any text input based on the live grammar.

>   Generator: Create new file names, logs, or even scripts by substituting values into the pattern.

>   Translator: Convert between representations—perhaps between the IR, the external spec, and final output—by applying transformation rules defined in your spec.

## Summary

Even if the target system does not have Rust installed, you can still have a dynamic resource resolution engine by building a self-contained binary. Such a binary reads an external specification file to determine its language grammar, token definitions, and transformation rules. This design ensures that your system evolves naturally as the spec changes, and you gain the flexibility to update tokens (like identifiers), add new fields, or adapt the parser/generator behavior without needing to reinstall or recompile the binary on the target system.

This approach moves the complexity into your build phase and runtime configuration, while delivering a lean, portable binary that adapts entirely from well-defined external files.

## 1. Defining a Formal Grammar DSL

Imagine that the target file name format is

DATE [IDENTIFIER] LABEL - NAME [SUFFIX]

We can write an EBNF-like grammar (for example, in a filename.pest file) that looks like this:

```
// filename.pest: Formal grammar for file names
// Each rule is modular so new tokens or fields can be added easily.
WHITESPACE  = _{ " " }
newline     =  _{ "\n" }

file_name   = { date ~ WHITESPACE ~ "[" ~ identifier ~ "]" ~ WHITESPACE ~ label ~ WHITESPACE ~ "-" ~ WHITESPACE ~ name ~ suffix? }

date        = { ASCII_DIGIT{4} ~ "-" ~ ASCII_DIGIT{2} ~ "-" ~ ASCII_DIGIT{2} }
identifier  = { "OA-NOTE-" ~ ASCII_DIGIT{3} }  // Change this production to update identifier structure!
label       = { ASCII_ALPHANUMERIC+ }
name        = { (!suffix ~ ANY)+ }
suffix      = { "." ~ (!newline ~ ANY)* }
```

Key Points of the DSL Design

>   Modularity:
>   Each token (e.g. date, identifier, etc.) is defined as its own rule; to change the identifier structure, you simply edit its rule.

>   Extensibility:
>   Adding a new field only requires adding a new production rule and updating file_name accordingly.

>   Transformations:
>   With this parse tree, you can write functions that traverse the Abstract Syntax Tree (AST) to update or translate certain tokens (for example, updating all labels of a given type).

>   Interactivity:
>   Once parsed, you can filter or search for nodes matching specific tokens (similar to using fzf for interactive filtering) and then reassemble the file name in a new format.

## 2. Implementing the Grammar in Rust

By using Rust and a parser like Pest, you’d have a strongly typed, composable pipeline. The code below shows a basic example of how you might use Pest to parse the file names, update tokens, and reassemble the strings.

```
// Cargo.toml dependencies:
// [dependencies]
// pest = "2.5"
// pest_derive = "2.5"

use pest::Parser;
use pest::iterators::Pair;
use std::fmt;

// Define our parser using the Pest grammar file (filename.pest)
#[derive(Parser)]
#[grammar = "filename.pest"] // relative path to your grammar definition file
struct FileNameParser;

// Define a struct to hold the parsed fields.
#[derive(Debug, Clone)]
struct FileName {
    date: String,
    identifier: String,
    label: String,
    name: String,
    suffix: Option<String>,
}

impl fmt::Display for FileName {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        if let Some(suf) = &self.suffix {
            write!(f, "{} [{}] {} - {}{}", self.date, self.identifier, self.label, self.name, suf)
        } else {
            write!(f, "{} [{}] {} - {}", self.date, self.identifier, self.label, self.name)
        }
    }
}

impl FileName {
    // Create a FileName instance from a Pest parse tree.
    fn from_pair(pair: Pair<Rule>) -> Self {
        let mut date = String::new();
        let mut identifier = String::new();
        let mut label = String::new();
        let mut name = String::new();
        let mut suffix = None;
        
        // Iterate over each inner pair in file_name
        for inner in pair.into_inner() {
            match inner.as_rule() {
                Rule::date => date = inner.as_str().to_string(),
                Rule::identifier => identifier = inner.as_str().to_string(),
                Rule::label => label = inner.as_str().to_string(),
                Rule::name => name = inner.as_str().to_string(),
                Rule::suffix => suffix = Some(inner.as_str().to_string()),
                Rule::WHITESPACE => {}, // skip whitespace tokens
                _ => unreachable!("Unexpected rule: {:?}", inner.as_rule()),
            }
        }
        
        FileName { date, identifier, label, name, suffix }
    }
    
    // Example: Update the label if it matches a certain criterion.
    fn update_label(&mut self, new_label: &str) {
        self.label = new_label.to_string();
    }
}

fn main() {
    // Example file name string:
    let file_str = "2025-03-13 [OA-NOTE-009] Prototype - Commands to bulk rename";
    
    // Parse the file name using the generated parser.
    let parse_result = FileNameParser::parse(Rule::file_name, file_str);
    match parse_result {
        Ok(mut pairs) => {
            // The first pair is the file_name rule.
            let file_pair = pairs.next().unwrap();
            let mut file_name = FileName::from_pair(file_pair);
            println!("Original: {}", file_name);

            // For example, update the label if it is "Prototype"
            if file_name.label == "Prototype" {
                file_name.update_label("Renaming");
            }
            println!("Updated: {}", file_name);
        }
        Err(e) => {
            eprintln!("Parsing error: {}", e);
        }
    }

    // In a real application, you might:
    // • Read a list of files from a directory.
    // • Use parallel processing (e.g., using Rayon) to parse each file name.
    // • Integrate with fzf for interactive filtering by printing out the AST or structure.
}
```

What This Rust Example Achieves

>   Explicit Grammar:
>   The Pest grammar file (written in an EBNF-style syntax) clearly defines the structure for your file names. Changes to tokens—such as modifying the identifier’s format—are done at the grammar level.

>   AST Generation and Transformation:
>   The parser builds an AST, which is then converted into a structured Rust type (FileName). This makes it easy to inspect, update, or transform any part of the file name. (For example, you can iterate over fields and update all “labels” that match a certain condition.)

>   Extensibility for Interactive Tools:
>   With a structured AST in memory, you can create functions that filter or query specific fields (akin to using fzf for fuzzy searching). You might build interactive command-line tools that list file names along with their semantic tokens and let you search or modify them.

>   Reusability and Composition:
>   The Rust implementation is modular: each production rule is isolated, transformation functions (like update_label) can be composed, and parsing errors are handled gracefully.

## 3. Summary: From Bash Regexes to a Realized DSL in Rust

>   Bash Prototype:
>   The Bash version concatenates regexes and uses sed to emit an intermediate representation. It serves well as a prototype but is fragile when rules change (e.g. modifying the identifier structure) or when you need to update tokens across many files.

>   Formal Grammar & DSL:
>   By drafting an explicit grammar (e.g., with Pest), your file naming conventions become an extensible language specification. You have a formal set of production rules that are easier to update and maintain.

>   Rust Implementation:
>   The Rust version reads this grammar, builds a strongly typed AST, and supports transformation functions. It’s much easier to extend (e.g., add fields or tokens) and to integrate with other tools (interactive filtering, parallel processing with Rayon, etc.).

This fully modular approach not only aligns with the category-theoretic principle of compositionality (combining simple transformations into complex ones) but also lays the groundwork for building a robust semantic resource resolution engine that can evolve along with your system’s needs.

---


#!/bin/bash
# --------------------------------------------------------------------------------------------
# Semantic File Renaming Prototype
#
# Summary:
# This script implements a semantic transformation pipeline for file names found in a
# target directory. Inspired by category theory’s emphasis on compositional structure,
# we build a formal grammar from modular regex fragments. Each fragment (such as date,
# identifier, label, etc.) is combined to form a full production rule that parses a
# file name. The pipeline then transforms the file name into an intermediate representation (IR) 
# by inserting semantic tokens. A second transformation step reconstructs the cleaned, standardized
# file name.
#
# Key points:
# • The file name schema is: DATE [IDENTIFIER] LABEL - NAME [SUFFIX]
# • Modular regex components serve as the formal grammar’s production rules.
# • An IR is generated to clearly tag each semantic field.
# • A downstream sed transformation strips the tokens to generate a standard output.
# • GNU Parallel demonstrates how these transformations can be applied concurrently.
#
# This structure is designed so that in the future you can build a parser, generator, or translator
# to automatically produce such scripts from a formal grammar.
# --------------------------------------------------------------------------------------------

# -------------------------------
# Section 0: Setup
# -------------------------------
# Set the target directory containing the files.
target_dir="../"

# List files from the target directory without additional formatting.
file_list=$(ls "$target_dir" --quoting-style literal --color=never)

# -------------------------------
# Section 1: Define Regex Components
# -------------------------------
# File name schema: DATE [IDENTIFIER] LABEL - NAME [SUFFIX]
#   DATE          -> e.g. 2025-03-13 (YYYY-MM-DD)
#   IDENTIFIER    -> e.g. OA-NOTE-009
#   LABEL         -> a single word (alphanumeric)
#   NAME          -> a text string (any characters except a literal dot)
#   SUFFIX        -> optional, typically begins with a dot
date_regex="([0-9]{4}-[0-9]{2}-[0-9]{2})"
identifier_regex="(OA-NOTE-[0-9]{3})"
label_regex="(\\w+)"                # double escapes are required for Bash strings
name_regex="([^\\.$]+)"              # exclude a literal dot and dollar sign
suffix_regex="([\\.]{0,1}[^$]*)\$"    # optional suffix starting with a dot

# -------------------------------
# Section 2: Build the Match Pattern and IR Replacement
# -------------------------------
# Construct the full match pattern by composing the individual regex components.
# The literal characters (spaces, brackets, dash) are included explicitly.
match_pattern="${date_regex}"' \['"${identifier_regex}"'\] '"${label_regex}"' - '"${name_regex}${suffix_regex}"

# The IR replacement defines semantic tokens that prefix each field.
ir_replacement="«DATE» \\1 «IDENTIFIER» \\2 «LABEL» \\3 «NAME» \\4 «SUFFIX» \\5"

# Build the sed substitution: replace the matched file name with its IR.
sed_pattern="s/${match_pattern}/${ir_replacement}/g"

# -------------------------------
# Section 3: Generate the Intermediate Representation (IR)
# -------------------------------
# Process the file list to produce the IR for each file name.
ir_file_list=$(echo "$file_list" | sed -Er "$sed_pattern")

# -------------------------------
# Section 4: Define the Output Grammar & Second Transformation
# -------------------------------
# Now define the tokens and the grammar for IR parsing.
ir_field_value="[^«$]*"  # Matches any characters until encountering a semantic token

# These tokens must match exactly the ones inserted above.
token_date="«DATE»"
token_identifier="«IDENTIFIER»"
token_label="«LABEL»"
token_name="«NAME»"
token_suffix="«SUFFIX»"

# Build the IR pattern that captures the semantic field values.
match_ir_values_regex="${token_date} (${ir_field_value}) ${token_identifier} (${ir_field_value}) ${token_label} (${ir_field_value}) ${token_name} (${ir_field_value}) ${token_suffix} (${ir_field_value})"

# The output replacement reconstructs the file name in the desired format:
# DATE IDENTIFIER LABEL - NAME [SUFFIX]
output_replacement="\\1 \\2 \\3 - \\4\\5"

# Create the sed command to transform the IR back to the final output.
output_sed="s/${match_ir_values_regex}/${output_replacement}/g"

# -------------------------------
# Section 5: Generate the Final Output
# -------------------------------
output_file_list=$(echo "$ir_file_list" | sed -Er "$output_sed")
# Uncomment the following line to see an example transformation:
# echo "$output_file_list" | tail -n 1

# -------------------------------
# Section 6: Batch Processing with GNU Parallel
# -------------------------------
# Export variables so they are available in the subshells spawned by GNU Parallel.
export sed_pattern output_sed

# Use GNU Parallel to process each file entry.
# Note: The --env flag passes the exported variables; --unsafe allows complex operations.
echo "$file_list" | parallel --env sed_pattern,output_sed --unsafe '
  original="{}"
  transformed=$(echo "$original" | sed -Er "$sed_pattern" | sed -Er "$output_sed")
  echo "$original -> $transformed"
'

# End of script



