# File: scripts/terminal-ai-transcript-index-builder.sh
# Description: 
#     Used to extract speech from transcripts.
#     Generates a list of conversation items for AI fine tuning
#       and batch summarisation.
#     To be used with the extract contents script to extract content
#     for batch processing.
# Example of the JSON output:
# ```json
# [
#   {
#     "timestamp": "2023-10-01T12:00:00Z",
#     "file": "/root/artifacts/logs/terminal-ai/transcripts/2024-07-22.md",
#     "speaker": "User",
#     "start_line": "50",
#     "end_line": "100",
#     "file_hash": "3a7bd3e2360a82bc8f3f1010ab6b4b16",
#   },
#   ...
# ]
# Usage with: ./scripts/explore-file 
# jq '. | map([.file, (.start_line | tonumber), (.end_line | tonumber) - (.start_line | tonumber)])' ~/artifacts/transcript-blocks.json | xargs explore-file -m content {filename} {start_line} {length}
# ```
DIRECTORY_TO_PROCESS="/root/artifacts/logs/terminal-ai/transcripts/"
files=$(find $DIRECTORY_TO_PROCESS -type f)
json_result="[]"

for file in $files; do
  end_line=$(wc -l < "$file")
  if [[ "$end_line" -eq 0 ]]; then
    continue
  fi

  # Get file hash and last modified date
  file_hash=$(md5sum "$file" | awk '{ print $1 }')

  tags=$(grep -oP --line-number '^\[[^,]+,[^]]+\]$' $file | sed 's#\(.*\):\[\(.*\),speaker=\(.*\)\]#\1,\2,\3#')
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
        "file_hash": $item_hash,
      }'
    )
    json_result=$(jq --argjson item "$json_entry" '. += [$item]' <<< "$json_result")
    #echo $timestamp $file $start_line $end_line
    #echo $file $start_line $end_line
    end_line="$start_line"
  done <<< "$tags"
done

echo "$json_result" > /root/artifacts/transcript-blocks.json
