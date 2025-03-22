# Literate Programming: A Self-Fulfilling Primer
## **Bootstrapping the Orchestration Architect Specifications**

**Status:** Rough Draft

## Introduction

The __Literate Programs Specification__ for *Orchestration Architect* is a reference implementation of the specifications.

The scope of this specification is to provide a POSIX shell command that can build the tool that can extract the relevant parts of the specification required to apply the macros to generate other specifications and source code.

The reference implementation should:

- Extract content from a `START_REGION_PATTERN` and `END_REGION_PATTERN`
- Extract the indented body of a function or macro and output it without the indent.
- List POSIX shell functions, macro names and markdown headers
- Perform embedding of macros depth first so that the resolution is achieved in a cascading process


##  Definitions

**Literate Blocks**

Literate Blocks are regions defined within a document that identifies that it is to be processed.



    ```oa-literate
        «content»
    ```

**Macros**

Macros are identified by the `«` and `»` symbols surrounding the label of the macro `«macro»` starting at the beginning of the line, with the body of the macro being indented until the `@` is found.

    «macro»
        «content to embed»
        @


The `«content to embed»` are can be other macros, content or both.



## Concepts

### Pre-orders

Pre-orders ensure that structural order is preserved under operations, guaranteeing that operations do not alter the order of elements or modify content unexpectedly.

An example is seen with nested macros, where enumerating (parent, child) pairs enables a topological sort. This allows macros with no dependencies to be rendered by concatenating instances within the file scope, storing the chunk for later use. When processing parent macros, only concatenation is required.

    
Deterministic extraction is achieved using `head -n+(end) | tail -n+(start)`, selecting regions by filtering to the last line by the end line number, then removing everything before the start line number.

The composition of `concat`, `grep` (to identify line numbers and extract content), and other operations ensures consistency in `embed`, `extract`, and `compose` operations, preserving content integrity by not changing the content or order.

This abstract pattern also applies to hierarchies like document outlines based on header levels, enabling documents to generate relationships and semantic context. A specification file with this structure can generate components and produce reports based on its internal structure, without requiring implementation knowledge.

When declaring the same macro multiple times, its contents are concatenated. To preserve operation order, use a macro for files to be included. Alternatively, declare separate macros for different functionalities, combining them into the «functions» macro under the Operation section.


## Implementation

### Find Regions

```bash
DEFAULT_START_PATTERN="^«[^»]+»"
DEFAULT_END_PATTERN="^\W{4}@"
SHELL_FUNC_START_PATTERN="^\w+\(\)\{"
SHELL_FUNC_END_PATTERN="^}$"

find_regions(){  

  local start_boundary_pattern="${1:-$DEFAULT_START_PATTERN}"
  local end_boundary_pattern="${2:-$DEFAULT_END_PATTERN}"

  local plane=$(cat)
  with_plane(){
    echo "$plane"
  }
  
  match_pattern(){
    local pattern="$1"    
    grep -E "$pattern" --line-number | cut -d: -f1
  }

  match_closest(){
    local pattern="$1"
    grep -m 1 -E "$pattern" --line-number | cut -d: -f1
  }
  # find identifiable regions
  region_boundary_list=$(with_plane | match_pattern "$start_boundary_pattern")
  # for each start boundary
  for start in ${region_boundary_list[@]}; do
    # offset the start, so the nearest region end can be identigfied
    local offset="$start"
    local distance=$(with_plane | tail -n"+$offset" | match_closest "$end_boundary_pattern")
    end=$((distance + offset - 1))
    echo "$start $end"
  done
}

test_match_bash_function(){
  file="$0"
  cat "$file" | find_regions "$SHELL_FUNC_START_PATTERN" "$SHELL_FUNC_END_PATTERN"
}

if [[ -n "$1" ]]; then
  if [[ "$1" == "help" ]]; then  
    test_match_bash_function "$0";
  elif [[ "$1" == "pattern" ]]; then
    find_regions "$2" "$3"
  else
    find_regions "$DEFAULT_START_PATTERN" "$DEFAULT_END_PATTERN"
  fi    
else
  find_regions "$DEFAULT_START_PATTERN" "$DEFAULT_END_PATTERN"
fi;
```


## Appendix

#### Generated Output of Example Specification

**Hello World Specification.md**


```bash
#!/bin/sh

function hello(){
  input=$(cat)
  echo "$input hi"
}

function world(){
  input=$(cat)
  echo "$input world"
}

function compose(){
  eval "$1" | eval "$2"
}

compose hello world
```

#### Example Specification

```oa-literate
    # Specification: 'Hello World' Program    
    ## Synopsis

    Running `sh ./hello-world` should output "Hi World".  
        
    ## Structure
    ```oa-literate
    «program»
        #!/bin/sh   
        «functions»
        compose hello world
        
    ```  
    ## The 'compose' Function
     
    This function is the 'Hello' string    
    ```oa-literate
     «functions»
     
        function compose(){
            eval "$1" | eval "$2"
        }        
        @
    ```       
    
    ## The 'Hello' Function
     
    This function is the 'Hello' string    
    ```oa-literate
     «functions»
        function hello(){
            input="$(cat)"
            echo "$input Hi"
        }
        @
    ```       
          
    ## The 'world' Function
    ```oa-literate
    «functions»
        function world(){
            input="$(cat)"
            echo "$input World"
        }
        @
    ```          
```
***    
    

