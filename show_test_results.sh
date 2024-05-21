##!/bin/bash

# Requirements
# (@srs=SRS-OA-UTIL-001) Provide an interactive interface to select from a list of timestamped directories within a specified parent directory.
# (@srs=SRS-OA-UTIL-002) Enable users to filter for specific patterns within the meta_component_bootstrap.log found in the selected timestamp directory and view contextual information from the grep results that identitfy 'TASK' and 'FAILED' and shows a limited context around the results.
# (@srs=SRS-OA-UTIL-003) Allow the user to navigate through the meta_component_bootstrap.log grep results from the file from the selected directory using a secondary interactive interface, with the most recent first and detailed context is displayed as the user moves through the grep matches (TASK|FAILED) (as you navigate through the different TASK|FAILED lines and the results show the full context aorund that line in the display.
# (@srs=SRS-OA-UTIL-004) Display a detailed preview of the context surrounding each filtered result to aid in detailed log analysis.
# (@srs=SRS-OA-UTIL-005) Automatically sort timestamped directories by their date, ensuring the most recent directory is selected and highlighted by default when the script is initiated. In the secondary display have the last result first (FAILED maybe) but otherwise it will be the most recent task ran

# Define the parent directory containing timestamped subdirectories
parent_dir="/tmp/orchestration_architect/logs/0.8.0/bootstrap_integration_test"
# Step 1: Use fzf to select a timestamped directory
# selected_dir=$(find "$parent_dir" -type d -name "*-*-*T*" | sort -r | fzf --prompt 'Select a timestamp directory: ' --preview 'ls {}' --preview-window down:70% --tiebreak=begin)
selected_dir=$(find "$parent_dir" -type d -name "*-*-*T*" | sort -r | fzf --prompt 'Select a timestamp directory: ' --preview "grep -nE 'TASK|FAILED' {}/meta_components_bootstrap.log | sort --numeric -r" --preview-window down:70% --tiebreak=begin)

# Check if a directory was selected
if [[ -z "$selected_dir" ]]; then
    echo "No directory selected."
    exit 1
fi

# Step 2: Process log files within the selected directory
# Assuming 'meta_component_bootstrap.log' exists within each timestamped directory
log_file="$selected_dir/meta_components_bootstrap.log"

# Use grep to filter for 'TASK' or 'FAILED', and use fzf to select from these entries
grep -nE 'TASK|FAILED' "$log_file" | sed 's!/tmp/orchestration_architect/0\.8\.0/tests/integration_environment!\<integration_execution_path>!g' | sort -r --numeric | fzf --ansi --delimiter ':' --preview "echo {} | cut -d':' -f1 | xargs -I{} tail -n +{} '$log_file'" --preview-window up:50%

