TRANSCRIPT_DIRECTORY="/root/artifacts/logs/terminal-ai/transcripts/"
#bat $(find "$TRANSCRIPT_DIRECTORY" -type f | sort | tail -n 1) --paging=always
WATCH_FILE="$(find "$TRANSCRIPT_DIRECTORY" -type f | sort | tail -n 1)"

inotifywait -m -e modify "$WATCH_FILE" -e create "$TRANSCRIPT_DIRECTORY" |  while read -r directory events filename; 
do
  terminal-ai-extract | bat --language="markdown"
done

