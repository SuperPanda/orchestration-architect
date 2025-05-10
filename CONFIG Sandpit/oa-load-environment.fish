#!/bin/fish
# Would be good to just loop through, or have some sort of 
# lens but for now
set -l source "$(pwd)/shell-configurations/orchestration-architect.fish"
set -l target "$HOME/.config/fish/conf.d/orchestration-architect.fish"
echo "Copying '$source' to '$target'..."
cp "$source" "$target"
echo "Copied '$source' to '$target'."


