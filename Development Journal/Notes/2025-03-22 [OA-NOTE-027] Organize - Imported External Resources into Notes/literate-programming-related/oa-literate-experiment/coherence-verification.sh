#!/bin/sh

# Core Primitive Operations
extract_region() {
    start=$1 end=$2
    head -n "$end" | tail -n "+$start"
}

find_regions() {
    start_pat=$1 end_pat=$2
    content=$(cat)
    
    # Find start boundaries
    starts=$(echo "$content" | grep -nE "$start_pat" | cut -d: -f1)
    
    # For each start, find next end
    for s in $starts; do
        e=$(echo "$content" | tail -n "+$s" | grep -nm 1 -E "$end_pat" | cut -d: -f1)
        [ -n "$e" ] && echo "$s $((s + e - 1))"
    done
}

# Monoidal Operations
identity() { cat; }  # Unit morphism

compose() {
    local f="$1" g="$2"
    while read -r line; do $f <<<"$line" | $g; done
}

tensor() {
    { "$1" & "$2" & } | cat  # Parallel composition
}

# Coherence Properties
left_identity() { head -n "+$1"; }  # head is left identity
right_identity() { tail -n "+$1"; } # tail is right identity

associativity_test() {
    # Verify (f⊗g)⊗h = f⊗(g⊗h)
    diff <(compose "$(compose "$1" "$2")" "$3") \
         <(compose "$1" "$(compose "$2" "$3")")
}

# Region Embedding
embed() {
    local outer_s=$1 outer_e=$2 inner_s=$3 inner_e=$4
    {
        extract_region 1 $((outer_s - 1))  # Before
        extract_region "$inner_s" "$inner_e"  # Embedded
        extract_region "$((outer_e + 1))" 1000000  # After  
    } < "${5:-/dev/stdin}"
}

# Usage Example ======================================================

# Define patterns
BASH_FUNC_START='^[a-zA-Z_][a-zA-Z0-9_]*()'
BASH_FUNC_END='^}'

# Test file with nested functions
cat > test.sh <<EOF
outer() {
    inner1() {
        echo "Nested"
    }
    
    inner2() {
        echo "Another"
    }
}
EOF

# Show monoidal composition
echo "Top-level functions:"
cat test.sh | find_regions "$BASH_FUNC_START" "$BASH_FUNC_END"

echo -e "\nNested functions:"
cat test.sh | find_regions "$BASH_FUNC_START" "$BASH_FUNC_END" | while read s e; do
    cat test.sh | extract_region "$s" "$e" | sed 's/^    //' | \
        find_regions "$BASH_FUNC_START" "$BASH_FUNC_END"
done

# Verify Coherence Properties
echo -e "\nTesting Associativity:"
associativity_test \
    "find_regions '$BASH_FUNC_START' '$BASH_FUNC_END'" \
    "head -n 5" \
    "grep -v '^#'"

echo "Testing Identity:"
diff test.sh <(cat test.sh | identity)
diff test.sh <(cat test.sh | compose "left_identity 1" "right_identity 1")
