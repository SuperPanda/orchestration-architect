#!/bin/bash
# File: scripts/monitor-outline.sh
# Description: Monitors changes in YAML files or directory trees, displaying an outline based on `- name:` or `- ansible.builtin.debug:` tags.
#              Allows monitoring of directory tree structures and tracks file modifications. Utilizes `fzf` for file selection if no specific file is provided.
# Usage: ./monitor-outline.sh [path_to_yaml_file_or_directory] [--tree | --track-modifications]
# (@project=OA-VIM)
# (@tool=OUTLINE-MONITOR)

# (@haiku=OA-HAIKU-005)
# Nesting layers deep,
# Indented names show outline,
# Numbered quick access.

# Requirements:
# (@srs=SRS-OA-OUTLINE-MONITOR-001) Provide file or directory selection interface using `fzf`.
# (@srs=SRS-OA-OUTLINE-MONITOR-002) Display updates in real-time for selected YAML files or directory trees.
# (@srs=SRS-OA-OUTLINE-MONITOR-003) Monitor entire directory trees and track file modifications with timestamps.

# Function to display the outline of a file
monitor_file() {
    local file=$1
    local last_modified=0

    while true; do
        local current_modified=$(stat -c %Y "$file")
        if [[ "$current_modified" != "$last_modified" ]]; then
            clear
            echo "Updated outline of $file:"
            local max_length=$(grep -nE '^( )*-( name:| ansible.builtin.debug:)' "$file" | cut -d: -f1 | wc -L)
            grep -nE '^( )*-( name:| ansible.builtin.debug:)' "$file" | sed 's/\- name\:/\* /g' | \
            awk -v max_length="$max_length" -F: '{printf "%-" max_length "s: %s\n", $1, $2}'
            last_modified=$current_modified
        fi
        sleep 5  # Check for changes every 5 seconds
    done
}
# Function to monitor a directory tree
monitor_tree() {
    local directory=$1
    local last_check=$(date +%s)

    while true; do
        find "$directory" -type f -newermt "@$last_check" -print0 | while IFS= read -r -d $'\0' file; do
            echo "$(date -r "$file" +"%F %T") - $file"
        done
        last_check=$(date +%s)
        sleep 5  # Check for new changes every 5 seconds
    done
}

# Main execution block
mode=$2
path=$1

if [[ -z "$path" || "$mode" == "--help" ]]; then
    echo "Usage: $0 [path_to_yaml_file_or_directory] [--tree | --track-modifications]"
    exit 1
fi

if [[ "$mode" == "--tree" ]]; then
    if [ -d "$path" ]; then
        echo "Monitoring directory tree: $path"
        monitor_tree "$path"
    else
        echo "Invalid directory path: $path"
        exit 1
    fi
else
    file=$(find "$path" -type f | fzf --height 40% --prompt "Select a file: ")
    if [[ -z "$file" ]]; then
        echo "No valid file selected or provided."
        exit 1
    fi

    if [ -f "$file" ]; then
        echo "Monitoring file: $file"
        monitor_file "$file"
    else
        echo "Provided path is not a file: $file"
        exit 1
    fi
fi

