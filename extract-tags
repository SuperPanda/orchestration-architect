#!/bin/bash

# Usage: ./extract_tags.sh <file>
# This script extracts lines from a specified file that contain tags formatted as # (@<tag>)
# and outputs the line number and file name.

# Check if a file argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

file="$1"

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# Define the pattern to search for tags
pattern='^# \((@[^)]*)\)'
error_pattern='^# @([^)]*)'

# Use grep to search for the pattern and output the line number and file name
# tabs
#grep "$pattern" "$file" | sed 's/^# //'  | awk '{ first_space=index($0, " "); print substr($0, 1, first_space-1) "\t" substr($0, first_space+1) }'
# space
#grep "$pattern" "$file" | sed 's/^# //'
# tags only
#grep "$pattern" "$file" | sed 's/^# //'  | cut -d' ' -f1

# line numbers
grep -nH "$pattern" "$file"
echo "Possible Typos"
grep -nH "$error_pattern" "$file"
