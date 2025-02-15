#!/bin/sh
# File: oa-literate-tangle.sh
PROJECT_CONTENTS_FILE="AXUM-VARIANT.md"
OUTPUT_DIRECTORY="tangled.d/"
# Potiential Improvements: Refactor to Memoise File Boundaries

# LIST THE BOUNDARIES FOR EMBEDDED ITEMS FROM THE MASTER FILE
# Outputs: <LINE_NUM>:[START|END]:<FILE_NAME>
function get_file_boundaries(){
  grep -noE "(START|END) OF FILE: (src/[\a-z]+.rs)" $PROJECT_CONTENTS_FILE | sed "s/ OF FILE: /:/g"
}

# LIST ALL THE EMBEDDED FILES
function get_list_of_files(){
  get_file_boundaries | cut -d: -f3 | uniq
}

# GET THE CONTENTS FROM THE EMBEDDED FILE FROM THE MASTER FILE 
function extract_file(){
  local file_name=$1
  local line_start=$(get_file_boundaries | grep "$file_name" | grep START | cut -d: -f1)
  local line_end=$(get_file_boundaries | grep "$file_name" | grep END | cut -d: -f1)
 num_lines=$((line_end-line_start))
 output_directory=`dirname $TEMP_OUTPUT_DIRECTORY/$file_name`
 output_file=`basename $file_name`
 mkdir -p $output_directory 
 # Extract via before end section (head +line_end)
 #   and after the start section (tail +line_start)
 #   and adjust to remove the headers
 cat $PROJECT_CONTENTS_FILE | head -n+$((line_end-1)) | tail -n+$((line_start+1)) > "$output_directory/$output_file"
}

# [TODO]
# Move Temporary Directory Contents to Target Location (suffixed with '.new') 
# Example:
# Move existing ./tangle.d ./.tangle.d.old/«next_available_integer»/tangle.d
#   «TEMP_OUTPUT_DIRECTORY»/src/ becomes ./tangle.d/src

# Setup Temporary Directory For Embedded File Extraction
TEMP_OUTPUT_DIRECTORY=`mktemp -d -t orchestration-architect-XXXXXXXXXX.tangle.d` || exit 1
# extract every embedded file
for file in $(get_list_of_files); do
  extract_file $file
done
echo "Tangled files successfully generated at: $TEMP_OUTPUT_DIRECTORY"
echo "Moving $TEMP_OUTPUT_DIRECTORY to $OUTPUT_DIRECTORY"
mkdir -p $OUTPUT_DIRECTORY
cp -r $TEMP_OUTPUT_DIRECTORY/* $OUTPUT_DIRECTORY
rm -rf $TEMP_OUTPUT_DIRECTORY
echo "Success!"
