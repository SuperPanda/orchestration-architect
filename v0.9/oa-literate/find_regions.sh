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
    #echo $distance $offset
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
  else
    find_regions "$DEFAULT_START_PATTERN" "$DEFAULT_END_PATTERN"
  fi    
else
  find_regions "$DEFAULT_START_PATTERN" "$DEFAULT_END_PATTERN"
fi;

#find_regions "$@"
