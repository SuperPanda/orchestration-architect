# File: scripts/terminal-ai-transcript-index-builder.sh
# Description: 
#     Used to extract speech from transcripts.
#     Generates a list of conversation items for AI fine tuning
#       and batch summarisation.
#     To be used with the extract contents script to extract content
#     for batch processing.
# Outputs:
#   [ [timestamp, filename, speaker, line_number_start, line_number_end]
#
DIRECTORY_TO_PROCESS=/root/artifacts/logs/terminal-ai/transcripts/
files=$(find $DIRECTORY_TO_PROCESS -type f)
#hashtable[key1]="value1"
#hashtable[key2]="value2"
#echo "${hashtable[key1]}"  # Outputs: value1
#echo "${hashtable[key2]}"  # Outputs: value2
json_result="[]"
for file in $files; do
  end_line=$(wc -l $file)
  if [[ $end_line -eq 0 ]]; then
    continue
  fi

  tags=$(grep -oP --line-number '^\[[^,]+,[^]]+\]$' $file | sed 's#\(.*\):\[\(.*\),speaker=\(.*\)\]#\1,\2,\3#')
  tags=$(echo "$tags" | sort -t, -k1,1r)  # Sort by line number in descending order 
  while IFS="," read -r start_line timestamp speaker; do
    json_entry=$(
      jq -n \
      --arg item_time "$timestamp" \
      --arg item_file "$file" \
      --arg item_speaker "$speaker" \
      --arg item_start "$start_line" \
      --arg item_end "$end_line" \
      '[$item_time, $item_file, $item_speaker, $item_start, $item_end]' \
      )
    json_result=$(jq --argjson item "$json_entry" '. += [$item]' <<< "$json_result")
    # echo $timestamp $file $start_line $end_line
    end_line=$start_line
  done <<< "$tags"
done

echo $json_result > /root/artifacts/transcript-blocks.json
