#!/bin/bash

# Generate an ISO 8601 timestamp
TIMESTAMP=$(date --iso-8601=seconds)

# Define the base log directory including the timestamp
BASE_LOG_DIR="/tmp/orchestration_architect/logs/0.8.0/bootstrap_integration_test/$TIMESTAMP"

# Create the directory
mkdir -p "$BASE_LOG_DIR"

# Define log file paths within the newly created timestamped directory
LOG_FILE="$BASE_LOG_DIR/meta_components_bootstrap.log"
TREE_FILE="$BASE_LOG_DIR/meta_components_bootstrap.tree"

# Initialize or overwrite the log file
echo '# file: '"$LOG_FILE" > "$LOG_FILE"
echo '# file: '"$TREE_FILE" > "$TREE_FILE"

# Run ansible-playbook and log output dynamically
ansible-playbook tests/integration/meta_components_bootstrap.yml "$@" | tee -a "$LOG_FILE" &

# Get the PID of the background process
ANSIBLE_PID=$!

# Tail the log in background and wait for ansible-playbook to finish
tail -f "$LOG_FILE" &
TAIL_PID=$!

wait $ANSIBLE_PID

# Kill the tail process after ansible-playbook finishes
kill $TAIL_PID

# Log the directory tree of /tmp/orchestration_architect after the playbook and tail are finished
tree /tmp/orchestration_architect >> "$TREE_FILE"

# Display the logs using bat and the tree output and copy to clipboard with wl-copy (if available)
bat "$LOG_FILE" "$TREE_FILE" | wl-copy

# Display the tree file content to the terminal
bat "$TREE_FILE"

