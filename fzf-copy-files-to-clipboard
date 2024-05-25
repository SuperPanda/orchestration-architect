##!/bin/bash

if [[ "$1" == "--again" ]]; then
  export LAST_SEARCH=$(cat ~/.last_copy)
  if [[ -n $LAST_SEARCH ]]; then
    echo "Repeating last search: $LAST_SEARCH"
    # Convert space-separated paths to newline-separated, handle each with xargs
    tr ' ' '\n' <<< "$LAST_SEARCH" | xargs -I {} bat --style=numbers '{}' | wl-copy
  else
    echo "No previous command to repeat."
  fi
else
  clear
  # Assuming fzf command works correctly and you just need to adjust the reading part
  export LAST_SEARCH=$(fzf -m --preview 'bat --style=numbers --color=always {}' --preview-window=right:70%:wrap)
  echo "$LAST_SEARCH" > ~/.last_copy
  echo "Selected file: $LAST_SEARCH"
  # Same adjustment as above for initial processing
  tr ' ' '\n' <<< "$LAST_SEARCH" | xargs -I {} bat --style=numbers '{}' | wl-copy
  clear
fi
