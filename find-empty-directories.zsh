#!/bin/zsh

# Find empty directories and pass them to fzf for user selection.
# The user can select multiple directories using the tab key.
# Selected directories are printed to stdout, separated by null characters.
selected_directories=$(find . -type d -empty | fzf --multi --print0)

# Check if any directories were selected.
if [ -z "$selected_directories" ]; then
  echo "No directories selected for deletion."
  exit 0
fi

# Confirm deletion of selected directories.
echo "You have selected the following directories for deletion:"
print -rn -- "$selected_directories" | xargs -0 -n1 echo
read "confirmation?Are you sure you want to delete these directories? (y/N): "

# If confirmation is given, proceed to delete the directories.
if [[ "$confirmation" =~ ^[Yy]$ ]]; then
  print -rn -- "$selected_directories" | xargs -0 rm -r
  echo "Selected directories have been deleted."
else
  echo "Deletion cancelled."
fi
