#!/bin/bash
# plugins/scripts/update_rendered_section.sh
# Script to sync sections from a source file to a destination file

# Script parameters
DESTINATION_FILE="$1"
SOURCE_FILE="$2"
BLOCK_ID="$3"
REGION_PARAM="${4:-}"

# Extract the region marker if specified, otherwise, it's left empty
REGION_MARK="${REGION_PARAM#*=}"
REGION_MARKER=""
if [[ "$REGION_PARAM" == "--region="* ]]; then
    REGION_MARKER="### $REGION_MARK ORCHESTRATION ARCHITECT REGION ###"
fi

# Function Definitions

function file_exists() {
  [[ -f "$1" ]]
}

function is_not_empty() {
    [[ -n "$1" ]]
}

function is_empty() {
    [[ -z "$1" ]]
}

function compare_checksum() {
    local old_content="$1"
    local new_content="$2"
    old_checksum=$(echo "$old_content" | md5sum | awk '{print $1}')
    new_checksum=$(echo "$new_content" | md5sum | awk '{print $1}')
    ! [ "$old_checksum" = "$new_checksum" ]
}

function extract_block() {
    local file="$1"
    local start_marker="$2"
    local end_marker="$3"
    sed -n "/$start_marker/,/$end_marker/p" "$file"
}

function find_region() {
    local file="$1"
    local region_marker="$2"
    grep -n "$region_marker" "$file" | cut -d: -f1 | head -1
}

function display_usage() {
    echo "Usage: $0 <DESTINATION_FILE> <SOURCE_FILE> <BLOCK_ID> [--region=<REGION>]"
    exit 1
}

function main() {
    if [ $# -lt 3 ]; then
        display_usage
    fi

    if ! command -v md5sum &> /dev/null; then
        echo "Error: md5sum command is required but not found."
        exit 1
    fi

    if ! file_exists "$DESTINATION_FILE" || ! file_exists "$SOURCE_FILE"; then
        echo "Error: Both old and new files must exist."
        exit 1
    fi

    START_MARKER="# BEGIN ORCHESTRATION ARCHITECT MANAGED BLOCK $BLOCK_ID"
    END_MARKER="# END ORCHESTRATION ARCHITECT MANAGED BLOCK $BLOCK_ID"

    # Handle special case for file header
    if [ "$BLOCK_ID" = "file_header" ]; then

      FILE_HEADER_DELIMITER="---"
      # Find the "---" marker in both files
      source_header_end_line=$(grep -n -m 1 -- "$FILE_HEADER_DELIMITER" "$SOURCE_FILE" | cut -d : -f 1)
      destination_header_end_line=$(grep -n -m 1 -- "$FILE_HEADER_DELIMITER" "$DESTINATION_FILE" | cut -d : -f 1)

      # Exit if "---" marker is not found in the new file
      if is_empty "$source_header_end_line"; then
          echo "Error: Header end marker '---' not found in the new file."
          exit 1
      fi
      # If "---" marker is not present in the old file, add the new file's content up to '---'
      if is_empty "$destination_header_end_line"; then
          TEMP_FILE=$(mktemp)
          head -n "$((source_header_end_line))" "$SOURCE_FILE" > "$TEMP_FILE"
          cat "$DESTINATION_FILE" >> "$TEMP_FILE"
          mv "$TEMP_FILE" "$DESTINATION_FILE"
          echo "Updated section header."
          exit 0

      fi
      # Calculate checksums for the header sections of both files
      destination_header_block=$(head -n "$destination_header_end_line" "$DESTINATION_FILE")
      source_header_block=$(head -n "$source_header_end_line" "$SOURCE_FILE")

      # Compare checksums to determine if the header needs to be updated
      if compare_checksum "$destination_header_block" "$source_header_block"; then
          echo "Header content differs, updating header..."

          # Prepare a temporary file for the updated content
          TEMP_FILE=$(mktemp)

          # Copy the new file's header section to the temporary file
          head -n "$source_header_end_line" "$SOURCE_FILE" > "$TEMP_FILE"

          # Append the rest of the old file's content, starting after the old header
          tail -n +$((destination_header_end_line + 1)) "$DESTINATION_FILE" >> "$TEMP_FILE"

          # Replace the old file with the updated content
          mv "$TEMP_FILE" "$DESTINATION_FILE"

          echo "Header updated successfully."
          exit 0
      else
          echo "Header content is already up to date; no update required."
          exit 0
      fi

    fi

    destination_block_start_line=$(grep -n -m 1 "$START_MARKER" "$DESTINATION_FILE" | cut -d : -f 1)
    destination_block_end_line=$(grep -n -m 1 "$END_MARKER" "$DESTINATION_FILE" | tail -n 1 | cut -d : -f 1)

    source_block_start_line=$(grep -n -m 1 "$START_MARKER" "$SOURCE_FILE" | cut -d : -f 1)
    source_block_end_line=$(grep -n -m 1 "$END_MARKER" "$SOURCE_FILE" | tail -n 1 | cut -d : -f 1)

    # Implement logic for comparing and updating blocks
    if is_not_empty "$destination_block_start_line" && is_not_empty "$source_block_start_line"; then
        # If both blocks exist, compare their content
        old_block=$(extract_block "$DESTINATION_FILE" "$START_MARKER" "$END_MARKER")
        new_block=$(extract_block "$SOURCE_FILE" "$START_MARKER" "$END_MARKER")

        if compare_checksum "$old_block" "$new_block"; then
          # Logic to update the block in $DESTINATION_FILE with $new_block
          echo "Section content differs, updating section..."
          TEMP_FILE=$(mktemp)

          # Include old content up to the start marker
          head -n $((destination_block_start_line)) "$DESTINATION_FILE" > "$TEMP_FILE"

          # Update old content from freshly rendered file from template
          echo "$new_block" >> "$TEMP_FILE"

          # Append content from the end marker to the end of the file
          tail -n +$((destination_block_end_line)) "$DESTINATION_FILE" >> "$TEMP_FILE"

          # Replace the target file with the updated content
          mv "$TEMP_FILE" "$DESTINATION_FILE"
          echo "Section updated successfully."
          exit 0
      else
          echo "Block $BLOCK_ID is already up to date."
          exit 0
      fi
    elif is_empty "$destination_block_start_line" && is_not_empty "$source_block_start_line"; then      
        # If the block is not in the DESTINATION_FILE but is in the SOURCE_FILE
        # Auto-detect region, if not specified
        echo "Block $BLOCK_ID not found in $DESTINATION_FILE. Inserting the block..."

        # If region is not explicitly specified, detect the region above the block in the SOURCE_FILE
        if is_empty "$REGION_MARKER" && is_not_empty "$source_block_start_line"; then
            echo "Region marker not specified, searching for region marker in source file"
            # Search backwards from the block start line to find the nearest region marker above it
            REGION_MARKER=$(tail -n +1 "$SOURCE_FILE" | head -n $(($source_block_start_line - 1)) | grep -E '### .+ ORCHESTRATION ARCHITECT REGION ###' | tail -1)
        fi
        TEMP_FILE=$(mktemp)

        # Find matching region in the DESTINATION_FILE, if REGION_MARKER is set
        if is_not_empty "$REGION_MARKER"; then
            echo "Inserting after section after: $REGION_MARKER"
            region_line=$(grep -n "$REGION_MARKER" "$DESTINATION_FILE" | cut -d: -f1 | head -1)
        else
            echo "No region marker found or specified for block insertion."
            exit 1
        fi
          
        if is_empty "$region_line"; then
            echo "Error: Specified region marker not found in the old file."
            exit 1
        fi
        
        echo "Destination file: $DESTINATION_FILE Source file: $SOURCE_FILE"

        echo "Copying everything up to and including the Region Marker line: $region_line"
        head -n "$region_line" "$DESTINATION_FILE" > "$TEMP_FILE"
        cat $TEMP_FILE
        echo >> "$TEMP_FILE"
        
        echo "Adding new block and copying contents"
        echo $START_MARKER >> "$TEMP_FILE"
        extract_block "$SOURCE_FILE" "$source_block_start_line" "$source_block_end_line" >> "$TEMP_FILE"
        echo $END_MARKER >> "$TEMP_FILE"


        echo "Adding original content after block insertion"
        tail -n +$((region_line + 1)) "$DESTINATION_FILE" >> "$TEMP_FILE"
    
        # Replace the old file with the updated content
        mv "$TEMP_FILE" "$DESTINATION_FILE"
        echo "Block $BLOCK_ID inserted successfully."
        exit 0
    fi
}

main "$@"

