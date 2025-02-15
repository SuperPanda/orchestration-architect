FUNCTION_START_PATTERN="^\w+\(\)\{"
FUNCTION_END_PATTERN="^}$"
MACRO_START_PATTERN="^«[^»]+»"
MACRO_END_PATTERN="^@"

extract_region(){
    local start="$1"
    local end="$2"
    head -n$((end)) | tail -n+$((start))
}

with_file(){
    local file="$1"; shift
    cat "$file" | "$@"
}


find_next_match_offset(){
  local pattern="$1"
  local cursor_start="${2:-1}"
  tail -n+$((cursor_start)) |  grep -m 1 -E $pattern --line-number| cut -d: -f1
}

find_regions(){ 

  local start_pattern="$1"
  local end_pattern="$2"
  state=`cat`

  match_line(){
    local pattern="$1"
    grep -E "$pattern" --line-number | cut -d: -f1
  }

  match_region(){
    local start="${1}"
    locla end="$(match_line $end_pattern $start)"
  }
  while read start; do 
    match_region $start_pattern $end_pattern
  done <<< $state

  region_start_lines=$( cat <<< $state | find_line_matches $start_boundary_pattern)
  for start_position in $start_positions_matches; do
    offset=$( cat <<< $state  | find_next_match_offset $end_boundary_pattern $start_position)
    end_position=$((start_position+offset-1))
    echo $start_position $end_position
  done
}


file_scope(){
  local file="${1:-$0}"
  region_boundary="$(cat "$file" | find_region_boundary $FUNCTION_START_PATTERN $FUNCTION_END_PATTERN)"

while read start end; do 

    function=$(cat $file | extract_region $start $start | tail -n 1 | sed -e "s/{//g")
    echo "---"
    echo Function $function from line $start to $end
    echo "---"
    cat "$file" | extract_region $start $end
    echo
  done <<< $region_boundary
}


get_bash_functions() {
  find_regions "${PATTERNS[bash_func]}" $FUNCTION_START_PATTERN $FUNCTION_END_PATTERN
}

with_file $get_bash_functions




