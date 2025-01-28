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
  local target_file=${2:-$FILE_TO_PROCESS}
  head -n $line_number "$target_file" | tail -n 1
}

get_line_range_from_file() {
  local start=$1
  local end=$2
  local target_file=${3:-$FILE_TO_PROCESS}
  tail -n`echo "+"$(($start))` "$target_file" | head -n`echo $(($end-$start))`
}

find_section() {
	declare -a section_start_lines
	line_numbers=$(grep -E "## Module: The \`([^\`]+)\` Collection" -w "$FILE_TO_PROCESS" --line-number | cut -d: -f1)
	section_start_lines=($line_numbers)
	for line_number in "${section_start_lines[@]}"; do
		#echo "$line_number"
		#head -n $line_number "$FILE_TO_PROCESS" | tail -n 1 | sed 's/## Module: /Found: /g'
		get_line_from_file $line_number | sed 's/## Module: /Found: /g'
	done
	for ((i=0; i<${#section_start_lines[@]}-1;i++)); do
		start=${section_start_lines[i]}
		end=${section_start_lines[i+1]-1}
		#echo "$start $end"
		#echo "tail -n+$start"
		#echo "head -n$(($end-$start))"
		#tail -n`echo "+"$(($start))` "$FILE_TO_PROCESS" | head -n`echo $(($end-$start))`
		get_line_range_from_file $start $end
		#tail -n`echo "+"$(($end - $start))` "$FILE_TO_PROCESS" #| head -n `$end - $start`
	done

}

find_section


