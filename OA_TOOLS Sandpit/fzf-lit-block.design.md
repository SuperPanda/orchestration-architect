

```bash «fzf-lit-block bash»
#!/usr/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
OA_CONFIG_PATH="$XDG_CONFIG_HOME/orchestration-architect/codeblock_search_paths.conf"
SEARCH_PATH_CONFIG="$OA_CONFIG_PATH/codeblock_search_paths.conf"

# Load search paths properly with spaces
SEARCH_PATHS=()
while IFS= read -r -d $'\n' line; do
    [ -n "$line" ] && SEARCH_PATHS+=("$line")
done < "$SEARCH_PATH_CONFIG_FILE"

# Use array for rg arguments to preserve spaces
rg_args=()
for path in "${SEARCH_PATHS[@]}"; do
    rg_args+=("$path")
done

# Define the sed pattern to match literate code blocks
pattern='^```[^«]+«[^»]+»$'

# Use fzf to select files containing literate codeblocks
selected_file=$(rg --no-ignore --files-with-matches "$pattern" --glob '*.md' "${rg_args[@]}" 2>/dev/null | \
    fzf --height=40% --border --preview 'bat --style=numbers --color=always {}')

if [[ -n "$selected_file" ]]; then
    # Extract all code blocks and their tags
    block_info=()
    while IFS= read -r -d $'\n' line; do
        if [[ $line =~ ^([0-9]+):.*\«([^\»]+)\» ]]; then
            start_line="${BASH_REMATCH[1]}"
            tag="${BASH_REMATCH[2]}"
            # Find the next closing ``` after the start line
            next_line=$((start_line + 1))
            end_line=$(sed -n "${next_line},\$ { /^```$/ =; }" "$selected_file" | head -n 1)
            if [[ -n "$end_line" ]]; then
                block_info+=("$start_line:$end_line:$tag")
            fi
        fi
    done < <(rg -n "$pattern" "$selected_file" 2>/dev/null)

    # Present tags in fzf for subselection with preview
    if [[ ${#block_info[@]} -gt 0 ]]; then
        # Generate display strings for fzf
        display_options=()
        for info in "${block_info[@]}"; do
            IFS=: read -r start end tag <<< "$info"
            display_options+=("$tag (lines $start-$end)")
        done

        selected_display=$(printf '%s\n' "${display_options[@]}" | \
            fzf --height=40% --border --prompt="Select codeblock: " \
                --preview "range=\$(grep -oE 'lines [0-9]+-[0-9]+' <<< {}); \
                          start=\$(cut -d' ' -f2 <<< \"\$range\" | cut -d'-' -f1); \
                          end=\$(cut -d'-' -f2 <<< \"\$range\"); \
                          sed -n \"\${start},\${end}p\" \"$selected_file\"")

        if [[ -n "$selected_display" ]]; then
            # Extract line numbers from selection
            range=$(grep -oE 'lines [0-9]+-[0-9]+' <<< "$selected_display")
            start_line=$(cut -d' ' -f2 <<< "$range" | cut -d'-' -f1)
            end_line=$(cut -d'-' -f2 <<< "$range")
            tag=$(sed -E 's/ \(lines [0-9]+-[0-9]+\)$//' <<< "$selected_display")

            # Extract and display code block
            extracted_block=$(sed -n "${start_line},${end_line}p" "$selected_file")
            echo -e "\n\033[1;32mExtracted Code Block [${tag}] from $selected_file:\033[0m"
            echo "$extracted_block"

            # Execution prompt
            echo -e "\nDo you want to execute the code block? (y/n)"
            read -r execute
            if [[ $execute == 'y' ]]; then
                # Remove code block markers (first and last lines)
                echo "$extracted_block" | sed '1d;$d' | bash
            fi
        else
            echo "No code block selected."
        fi
    else
        echo "No literate code blocks found in $selected_file."
    fi
else
    echo "No file selected."
fi
```

#### 3. Make the Script Executable

Ensure the script is executable:
```sh
chmod +x fzf-search-codeblocks.sh
```


```sh «fzf-lit-block.fish»
#!/usr/bin/fish

# Ensure XDG_CONFIG_HOME is set
if not set -q XDG_CONFIG_HOME
    set -gx XDG_CONFIG_HOME "$HOME/.config"
end

# Set OA_CONFIG_PATH and ensure it exists
set -gx OA_CONFIG_PATH "$XDG_CONFIG_HOME/orchestration-architect"
if not test -d "$OA_CONFIG_PATH"
    mkdir -p "$OA_CONFIG_PATH"
end

# Create default search paths file if needed
set search_paths_file "$OA_CONFIG_PATH/codeblock_search_paths.conf"
if not test -e "$search_paths_file"
    # Create with default search paths
    echo "# Add search paths for literate code blocks (one per line)" > "$search_paths_file"
    echo "$HOME/Documents" >> "$search_paths_file"
    echo "$HOME/Documents/Daily Notes" >> "$search_paths_file"
    echo "# Example: /path/to/your/notes" >> "$search_paths_file"
end

# Load search paths
set search_paths
if test -e "$search_paths_file"
    while read -l line
        # Skip comments and empty lines
        if string match -qr '^[^#]' -- "$line" && test -n "$line"
            set -a search_paths "$line"
        end
    end < "$search_paths_file"
end

# Fallback to current directory if no paths defined
if test (count $search_paths) -eq 0
    set search_paths "."
end

# Define pattern for literate codeblocks
set pattern '^```[^«]+«[^»]+»$'

# Find files with literate codeblocks
set -l selected_file ( \
    rg --no-ignore --files-with-matches "$pattern" --glob '*.md' $search_paths 2>/dev/null | \
    fzf --height=80% --style=full --border --preview 'bat --style=numbers --color=always {}' \
)

if test -n "$selected_file"
    # Find all codeblock start lines
    set block_starts (rg -n "$pattern" "$selected_file" 2>/dev/null | \
        string replace -r '^([0-9]+):.*$' '$1' \
    )

    # Find matching end lines for each start
    set block_info
    for start in $block_starts
        # Find next closing codeblock after start line
        set end (rg -n '^```$' "$selected_file" 2>/dev/null | \
            string replace -r '^([0-9]+):.*$' '$1' | \
            while read -l line_num
                test "$line_num" -gt "$start" && echo "$line_num" && break
            end
        )
        
        # Extract tag from codeblock
        set tag (sed -n "$start p" "$selected_file" | \
            string replace -r '^.*«([^»]+)».*$' '$1' \
        )
        
        if test -n "$end" && test -n "$tag"
            set -a block_info "$start:$end:$tag"
        end
    end

    if test (count $block_info) -gt 0
        # Present tags in fzf for subselection
        set selected_block (printf '%s\n' $block_info | \
            fzf --height=40% --border --prompt="Select codeblock: " \
                --preview="set parts (string split ':' '{1}'); \
                    set start \"\$parts[1]\"; set end \"\$parts[2]\"; \
                    sed -n \"\$start,\$end p\" \"$selected_file\"" \
        )

        if test -n "$selected_block"
            # Parse selected block info
            set parts (string split ':' "$selected_block")
            set start "$parts[1]"
            set end "$parts[2]"
            set tag "$parts[3]"

            # Extract codeblock content
            set extracted_block (sed -n "$start,$end p" "$selected_file")

            # Display extracted block
            echo -e "\n\033[1;32mExtracted Code Block [$tag] from $selected_file:\033[0m"
            echo "$extracted_block"

            # Execution prompt
            echo -e "\nDo you want to execute the code block? (y/n)"
            read -P "" execute

            if test "$execute" = 'y'
                # Strip codeblock markers using head/tail
                echo "$extracted_block" | tail -n +2 | head -n -1 | bash
            end
        else
            echo "No code block selected."
        end
    else
        echo "No literate code blocks found in $selected_file."
    end
else
    echo "No file selected."
end
```
