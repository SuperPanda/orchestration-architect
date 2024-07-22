# File: scripts/terminal-ai-transcript-indexer
# Description: 
#     This script is used to extract speech components from transcripts.
#     It generates a list of conversation items for AI fine tuning
#     and batch summarization. The outputted list can be used with the 
#     extract contents script for batch content processing.
# Example of the JSON output:
# ```json
# [
#   {
#     "timestamp": "2023-10-01T12:00:00Z",
#     "file": "/root/artifacts/logs/terminal-ai/transcripts/2024-07-22.md",
#     "speaker": "User",
#     "start_line": "50",
#     "end_line": "100",
#     "file_hash": "3a7bd3e2360a82bc8f3f1010ab6b4b16"
#   },
#   ...
# ]
# ```
# Example: How to use this script to generate a collection of conversation blocks to be sent for batch processing:
# ```
# jq -c '. | map([.file, .file_hash, (.start_line | tonumber), (.end_line | tonumber) - (.start_line | tonumber)]) | .[] | @tsv' ~/artifacts/transcript-blocks.json --raw-output | xargs -I{} bash -c 'set -- {}; explore-file -m content -o "/tmp/$2/$3" $1 $3 $4'
# ```
# Application: How the terminal-ai-extract command will be reworked.
# Instead of using the '---' delimiters to search the file and return the n-th last block, it will find the latest file, and then call this script to better navigate the file. This will replace the explore-file script (which will be repurposed for adjusting the line numbers for blocks and tags in an interactive fashion).

# Function to display help
show_help() {
  cat << EOF
Usage: terminal-ai-transcript-indexer [--update] [--index-file=<INDEX_FILE_PATH>] [--target-path=<INDEX_TARGET_PATH>] [--help]
Options:
  --update           Generate the index for the provided INDEX_TARGET_PATH (default: $DEFAULT_DIRECTORY_TO_PROCESS) and output the index contents to INDEX_FILE_PATH (default: $DEFAULT_INDEX_FILE). If omitted, the index will be output to stdout.
  --index-file=<INDEX_FILE_PATH> Specify a custom file to write the index to (when --update is provided) or to read from when the indexed file has not changed (feature coming soon).
  --target-path=<INDEX_TARGET_PATH> Specify the path (file or directory) to be processed when generating the index. Overrides the default directory for the current script invocation.
  --help             Display this help message and exit.
EOF
}

PERFORM_UPDATE=0
DEFAULT_DIRECTORY_TO_PROCESS="/root/artifacts/logs/terminal-ai/transcripts/"
DEFAULT_INDEX_FILE="/root/artifacts/transcript-blocks.json"

INDEX_TARGET_PATH=""
INDEX_FILE_PATH=""

# Parse command-line arguments
while [[ "$1" == --* ]]; do
  case $1 in
    --target-path=*)
      INDEX_TARGET_PATH="${1#*=}"
      shift
      ;;
    --index-file=*)
      INDEX_FILE_PATH="${1#*=}"
      shift
      ;;
    --update)
      PERFORM_UPDATE=1
      shift
      ;;
    --help)
      show_help
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      exit 1
      ;;
  esac
done

# Set defaults if paths are not provided
if [[ -z "$INDEX_FILE_PATH" ]]; then
  INDEX_FILE_PATH="$DEFAULT_INDEX_FILE"
fi

if [[ -z "$INDEX_TARGET_PATH" ]]; then
  INDEX_TARGET_PATH="$DEFAULT_DIRECTORY_TO_PROCESS"
fi

# Verify if provided paths exist
if [[ ! -d "$INDEX_TARGET_PATH" && ! -f "$INDEX_TARGET_PATH" ]]; then
  echo "Error: TARGET_PATH '$INDEX_TARGET_PATH' does not exist."
  exit 1
fi

files=$(find "$INDEX_TARGET_PATH" -type f)
json_result="[]"

for file in $files; do
  end_line=$(wc -l < "$file")
  if [[ "$end_line" -eq 0 ]]; then
    continue
  fi

  # Get file hash and last modified date
  file_hash=$(md5sum "$file" | awk '{ print $1 }')

  tags=$(grep -oP --line-number '^\[[^,]+,[^]]+\]$' "$file" | sed 's#\(.*\):\[\(.*\),speaker=\(.*\)\]#\1,\2,\3#')
  tags=$(echo "$tags" | sort -t',' -r -g)  # Sort by line number in descending order 
  while IFS="," read -r start_line timestamp speaker; do
    json_entry=$(
      jq -n \
      --arg item_time "$timestamp" \
      --arg item_file "$file" \
      --arg item_speaker "$speaker" \
      --arg item_start "$start_line" \
      --arg item_end "$end_line" \
      --arg item_hash "$file_hash" \
      '{
        "timestamp": $item_time,
        "file": $item_file,
        "speaker": $item_speaker,
        "start_line": $item_start,
        "end_line": $item_end,
        "file_hash": $item_hash
      }'
    )
    json_result=$(jq --argjson item "$json_entry" '. += [$item]' <<< "$json_result")
    end_line="$start_line"
  done <<< "$tags"
done

# Output the result to either standard output or the specified index file
if [[ "$PERFORM_UPDATE" -eq 0 ]]; then
  echo "$json_result"
else
  echo "$json_result" > "$INDEX_FILE_PATH"
fi
