#!/bin/bash
# file: scripts/explore_file.sh
# Set default values
DEFAULT_INIT_START_LINE=1
DEFAULT_INIT_NUM_LINES=10
DEFAULT_MODE="info"  # Default mode outputs content
OUTPUT_FILE=""  # No default output file, use temporary locations unless specified

factor=1
# mode can be copy, all, content, info
# Function to handle option parsing for mode, filename, and output file
parse_options() {
    mode=$DEFAULT_MODE
    while getopts ":m:o:" opt; do
        case ${opt} in
            m ) mode=${OPTARG} ;;
            o ) OUTPUT_FILE=${OPTARG} ;;
            \? ) echo "Usage: $0 [-m mode] [-o output_file] filename [start_line [length]]"
                 exit 1 ;;
        esac
    done
    shift $((OPTIND -1))
    
    file_name="$1"
    start_line="${2:-$DEFAULT_INIT_START_LINE}"
    length="${3:-$DEFAULT_INIT_NUM_LINES}"
}

parse_options "$@"
if ! command -v fzf &> /dev/null; then
    echo "fzf could not be found, please install it."
    exit 1
fi
if ! command -v wc &> /dev/null; then
    echo "wc could not be found, please install core utilities."
    exit 1
fi
if ! command -v wl-copy &> /dev/null; then
    echo "wl-copy could not be found, please install wl-clipboard."
    exit 1
fi


# Function to display content based on the current window defined by start_line and length
display_content() {
    total_lines=$(wc -l < "$file_name")
    if (( start_line + length - 1 > total_lines )); then
        if (( start_line > total_lines )); then
            start_line=$(( total_lines - length + 1 ))
            (( start_line < 1 )) && start_line=1
        fi
    fi
    content=$(tail -n +$start_line "$file_name" | head -n $length)
    clear
    echo "$content"
    echo "--------------------------------"
    echo "Start line: $start_line, Number of lines: $length, Factor: x$factor"
    echo "Use arrow keys to adjust. Use ',' and '.' to change factor. Enter to copy to clipboard. Use 'j' to jump to specific line"
}

# Validate file name
if [[ -z "$file_name" ]]; then
    # No filename provided, use fzf to select a file
    file_name=$(find . -type f | fzf --height 40% --border)
    if [[ -z "$file_name" ]]; then
        echo "No file selected, exiting."
        exit 1
    fi
elif [[ ! -f "$file_name" ]]; then
    echo "File does not exist: $file_name"
    exit 1
fi

# Validate and set the starting line if a line number is provided
if [[ -n "$line_number" ]]; then
    if [[ "$line_number" =~ ^[0-9]+$ ]] && (( line_number > 0 )); then
        start_line=$line_number
    else
        echo "Invalid line number provided. Starting from line 1."
    fi
fi

# Validate and set the length if number of lines is provided
if [[ -n "$num_lines" ]]; then
    if [[ "$num_lines" =~ ^[0-9]+$ ]] && (( num_lines > 0 )); then
        length=$num_lines
    else
        echo "Invalid number provided. Displaying 10 lines."
    fi
fi
# Display the content initially
display_content
# Function to display and process content based on the current mode
process_content() {
    # Decide on default output files if OUTPUT_FILE is not specified
    if [[ -z $OUTPUT_FILE ]]; then
        case $mode in
            all) OUTPUT_FILE="/tmp/fragment" ;;
            info) OUTPUT_FILE="/tmp/mark" ;;
            content) OUTPUT_FILE="/tmp/content" ;;
            *) OUTPUT_FILE="/dev/null" ;;
        esac
    fi

    case $mode in
        all)
            echo "$file_name $start_line $length" >> $OUTPUT_FILE
            tail -n +$start_line "$file_name" | head -n $length >> $OUTPUT_FILE
            echo "---" >> $OUTPUT_FILE
            ;;
        info)
            echo "$file_name $start_line $length" >> $OUTPUT_FILE
            ;;
        content)
            tail -n +$start_line "$file_name" | head -n $length >> $OUTPUT_FILE
            echo "---" >> $OUTPUT_FILE
            ;;
        copy)
            tail -n +$start_line "$file_name" | head -n $length | wl-copy
            echo "Content copied to clipboard."
            ;;
    esac
}
# Key press handling loop
while IFS= read -r -n1 key; do
    case $key in
        'j')  # 'j' key to jump to a specific line
            echo -n "Enter line number to jump to: "
            read line_number
            if [[ "$line_number" =~ ^[0-9]+$ ]] && (( line_number > 0 )) && (( line_number <= total_lines )); then
                start_line=$line_number
                # Adjust start_line to not exceed file boundaries with the current window size
                (( start_line + length - 1 > total_lines )) && start_line=$(( total_lines - length + 1 ))
                (( start_line < 1 )) && start_line=1
            else
                echo "Invalid line number."
            fi
            display_content  # Refresh display after any change
            ;;  
        '.')  # Increase factor by multiplying
            ((factor *= 10))
            display_content  # Refresh display after any change
            ;;
        ',')  # Decrease factor by dividing
            ((factor > 1)) && ((factor /= 10))
            display_content  # Refresh display after any change
            ;;
        $'\x1b') # Arrow keys and Enter
            read -r -n2 key
            case $key in
                '[A') # Up arrow
                    if (( start_line - factor >= 1 )); then
                        ((start_line -= factor))
                    else
                        start_line=1
                    fi
                    ;;
                '[B') # Down arrow
                    if (( start_line + factor <= total_lines - length + 1 )); then
                        ((start_line += factor))
                    else
                        start_line=$(( total_lines - length + 1 ))
                        (( start_line < 1 )) && start_line=1
                    fi
                    ;;
                '[C') # Right arrow
                    if (( length + factor <= total_lines - start_line + 1 )); then
                        ((length += factor))
                    else
                        length=$(( total_lines - start_line + 1 ))
                    fi
                    ;;
                '[D') # Left arrow
                    if (( length - factor >= 1 )); then
                        ((length -= factor))
                    fi
                    ;;
            esac
            display_content  # Refresh display after any change
            ;;
        'q') # Exit
            echo "Exiting..."
            exit 0
            ;;
        "")  # Enter key
            process_content
            exit 0
    esac
done

