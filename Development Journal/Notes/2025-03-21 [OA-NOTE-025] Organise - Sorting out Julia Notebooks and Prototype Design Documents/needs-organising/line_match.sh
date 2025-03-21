FUNCTION_MATCH_PATTERN="^\w+\(\)\{"
extract_region(){
    local start="$1"
    local end="$2"
    head -n+$((end)) | tail -n+$((start))
}
extract_file_region(){
    local file="$1"
    local start="$2"
    local end="$3"
    #head -n`echo "+"$(($end))` "$file" | tail -n`echo "+"$(($start))`
    head -n+$((end)) "$file" | tail -n+$((start))
}


find_line_matches(){
  local pattern="$1"
  grep -E $pattern --line-number
}

#cat ./test.sh | extract_region 2 4
cat ./test.sh | find_line_matches $FUNCTION_MATCH_PATTERN



