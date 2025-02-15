#!/bin/bash

# Core Primitive: Region Extraction
extract_region() {
    local start="$1" end="$2"
    sed -n "${start},${end}p"
}

# Core Primitive: Boundary Detection
find_regions() {
    local start_pat="$1" end_pat="$2"
    awk -v start="$start_pat" -v end="$end_pat" '
        $0 ~ start { s = NR }
        $0 ~ end && s { print s, NR; s = 0 }
    '
}

# File Handling with Scopes
with_file() {
    local file="$1"; shift
    cat "$file" | "$@"
}

# Pattern Definitions
declare -A PATTERNS=(
    [bash_func]='^\w+\{' 
    [bash_func_end]='^\}'
    [macro]='^«[^»]+»'
    [macro_end]='^\W{2,4}@'
    [markdown_h2]='^## '
    [markdown_h2_end]='^(## |$)'
)

# Example Composition: Extract Bash Functions
get_bash_functions() {
    find_regions "${PATTERNS[bash_func]}" "${PATTERNS[bash_func_end]}"
}

# Example Composition: Extract Macros 
get_macros() {
    find_regions "${PATTERNS[macro]}" "${PATTERNS[macro_end]}"
}

# Advanced Usage: Monoidal Composition
concat_regions() {
    local file="$1"; shift
    while read start end; do
        with_file "$file" extract_region $start $end
    done | cat -s
}

# Resolve macro dependencies using tsort
resolve_macros() {
    local file="$1"
    # Create dependency graph
    with_file "$file" get_macros | awk '{print "«"$2"»", $1}' |
    tsort | tac | while read macro; do
        with_file "$file" resolve_single_macro "$macro"
    done
}


# Usage Pipeline Example
with_file ./sample.sh get_bash_functions | while read start end; do
    echo "Function region: $start-$end"
    with_file ./test.sh extract_region $start $end
done

# Usage Pipeline Example
with_file ./sample.sh get_bash_functions | while read start end; do
    echo "Function region: $start-$end"
    with_file ./test.sh extract_region $start $end
done

