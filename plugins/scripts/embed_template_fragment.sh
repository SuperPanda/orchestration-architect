#!/bin/bash

# Default marker ID if not provided
DEFAULT_MARKER_ID="ORCHESTRATION ARCHITECT FRAGMENT"
INPUT_FILE="$1"
TARGET_FILE="$2"
BLOCK_ID="$DEFAULT_MARKER_ID $3"
START_MARKER="{# BEGIN ${BLOCK_ID} #}"
END_MARKER="{# END ${BLOCK_ID} #}"

# Verify the existence of md5sum or an equivalent command
if ! command -v md5sum &> /dev/null; then
    echo "Error: md5sum command could not be found."
    exit 1
fi

# Ensure both input and target files exist
if [ ! -f "$INPUT_FILE" ] || [ ! -f "$TARGET_FILE" ]; then
    echo "Error: Input file or target file does not exist."
    exit 1
fi

# Find the line numbers for start and end markers
start_line=$(grep -n -m 1 "$START_MARKER" "$TARGET_FILE" | cut -d : -f 1)
end_line=$(grep -n -m 1 "$END_MARKER" "$TARGET_FILE" | tail -n 1 | cut -d : -f 1)

# Exit if markers are not found in the target file
if [ -z "$start_line" ] || [ -z "$end_line" ]; then
    echo "Error: Block markers not found in the target file."
    exit 1
fi

# Extract the current block content between markers
current_block=$(sed -n "$((start_line + 1)),$((end_line - 1))p" "$TARGET_FILE")
current_hash=$(echo "$current_block" | md5sum | cut -d ' ' -f 1)

# Calculate the hash of the input file
input_hash=$(md5sum "$INPUT_FILE" | cut -d ' ' -f 1)

# Compare hashes and update the target file if they differ
if [ "$current_hash" != "$input_hash" ]; then
    echo "Block content differs, updating block..."
    TEMP_FILE=$(mktemp)

    # Include content up to the start marker
    head -n $((start_line)) "$TARGET_FILE" > "$TEMP_FILE"

    # Insert new content from the input file
    cat "$INPUT_FILE" >> "$TEMP_FILE"

    # Append content from the end marker to the end of the file
    tail -n +$((end_line)) "$TARGET_FILE" >> "$TEMP_FILE"

    # Replace the target file with the updated content
    mv "$TEMP_FILE" "$TARGET_FILE"
    echo "Block updated successfully."
else
    echo "Block content is already up to date; no update required."
fi

