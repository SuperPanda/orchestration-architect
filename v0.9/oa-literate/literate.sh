#!/bin/bash
# Experiment: Generate Functor To Map Documentation to Semantic Resource Description Framework Schema
# Purpose: Utilise Literate Writing to Achieve Generative (Cascade) Effects
# Stage 1: Generate a Framework for Writing and Parsing Elements
# Stage 2: Map Elements to RDF(S)
# Stage 3: Use RDFS to Generate and Parse Specifications to Generate OA V0.9
#export OA_LITERATE_TOOLS_STATE_PATH="/tmp/Orchestration Architect/literate/state"
FILE_TO_PROCESS="OA Modules.md"
CURSOR_HEAD=0
CURSOR_TAIL=$(wc "$FILE_TO_PROCESS" | cut -f2 -d' ')

get_line_from_file() {
  local line_number=$1
  local target_file="${2:-$FILE_TO_PROCESS}"
  head -n $line_number "$target_file" | tail -n 1
}

get_line_range_from_file() {
  local start=$1
  local end=$2
  local target_file="${3:-$FILE_TO_PROCESS}"
  echo "$target_file"
  tail -n`echo "+"$(($start))` "$target_file" | head -n`echo $(($end-$start))`
}


find_title_in_file() {
	local target_file="${1:-$FILE_TO_PROCESS}"
	grep -E "^# (.+)$" "$target_file"
}

get_matching_line_numbers() {
	local match_pattern=${1:-"^[#]+ (.+)$"}
	local target_file="${2:-$FILE_TO_PROCESS}"
	grep -E "$match_pattern" -w "$target_file" --line-number | cut -d: -f1
}

find_section_in_file() {
	local match_pattern="${1:-^## (.+)$}"
	local target_file="${2:-$FILE_TO_PROCESS}"
	declare -a section_start_lines
	#line_numbers=$(grep -E "## Module: The \`([^\`]+)\` Collection" -w "$target_file" --line-number | cut -d: -f1)
	#line_numbers=$(grep -E "$match_pattern" -w "$target_file" --line-number | cut -d: -f1)
	line_numbers=$(get_matching_line_numbers "$match_pattern" "$target_file")
	#echo "$line_numbers"
	section_start_lines=($line_numbers)
	for line_number in "${section_start_lines[@]}"; do
		get_line_from_file $line_number "$target_file" | sed -E "s/$(echo $match_pattern)/\1/g"
	done
	for ((i=0; i<${#section_start_lines[@]}-1;i++)); do
		start=${section_start_lines[i]}
		end=${section_start_lines[i+1]-1}
		#get_line_range_from_file $start $end "$target_file"
	done

}

get_document_outline(){
	local target_file=${1:-$FILE_TO_PROCESS}
	grep -E "^[#]+" "$target_file"
}

get_outline(){
	declare -A outline_line_numbers
	declare -A outline_items
	#outline_items=$(find_section_in_file "^([#]+ .+)$") # THIS IS OUTLINE#LINE_CONTENT
	outline_line_numbers=$(get_matching_line_numbers "^([#]+ .+)$") # THIS IS OUTLINE#LINE_NUMBER
	#outline_items = find_section_in_file "^([#]+ .+)$" # THIS IS OUTLINE
	#local outline_line_numbers=$(get_matching_line_numbers "^(#+ .+)$") #THIS IS NUMBERS
	#echo "OUTLINE LINE NUMBERS: " $outline_line_numbers
	local outline_index=0
	declare -A outline
	for line_number in $outline_line_numbers; do
	#echo "ADDING LINE $line_number"
		#echo "RETRIEVING ELEMENT ${outline_index} FROM OUTLINE ITEMS"
		outline_value=$(get_line_from_file $(($line_number)))
		outline_index="$(($outline_index+1))"
	#echo "RETRIEVED ITEM: $outline_value"
		outline_depth=$((`echo $outline_value | sed -E "s/^([#]+).+$/\1/g" | wc -c` - 1))
		outline[$outline_index]="$outline_index,$line_number,$outline_depth,$outline_value"
	done
	outline_keys=${!outline[@]}
	sorted_keys=$(echo $outline_keys | tr ' ' '\n' | sort -n | paste -sd ' ' -)
	local output=""
	for k in $sorted_keys; do
		value=${outline[$k]}
		#IFS=',' read -r o1 o2 o3 o4 <<< "$value"		
		output+="$value\n"
	done
	echo -e $output | column --table -s',' --table-columns=order,line_number,level,title
	
}

# OLD STUFF
#line_numbers=$(grep -E "## Module: The \`([^\`]+)\` Collection" -w "$target_file" --line-number | cut -d: -f1)

# DEMO
#find_title_in_file
#find_section_in_file #"## (\w+): The \`([^\`]+\`) (\w+)"

#find_section_in_file "^## (\w+)" # THIS MATCHES LEVEL 2 HEADERS
#get_matching_line_numbers "^## (\w+)" # THIS IS LINE NUMBER FOR LEVEL 2 HEADERS

#find_section_in_file "^([#]+ .+)$" # THIS IS OUTLINE
#get_matching_line_numbers "^([#]+ .+)$" # THIS IS OUTLINE

get_outline

#find_section_in_file
#find_section_in_file "## Module: The \`([^\`]+)\` Collection" # THIS EXTRACTS A WORD
#find_section_in_file "## (\w+: The \`[^\`]+\` \w+)" # THIS EXTRACTS EVERYTHING MATCHING PATTERN
#get_document_outline

