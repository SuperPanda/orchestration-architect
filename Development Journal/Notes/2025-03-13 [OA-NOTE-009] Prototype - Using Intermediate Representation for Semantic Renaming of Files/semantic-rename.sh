#!/bin/bash
# --------------------------------------------------------------------------------------------
# Semantic File Renaming Prototype
#
# Summary:
# This script implements a semantic transformation pipeline for file names found in a
# target directory. Inspired by category theory’s emphasis on compositional structure,
# we build a formal grammar from modular regex fragments. Each fragment (such as date,
# identifier, label, etc.) is combined to form a full production rule that parses a
# file name. The pipeline then transforms the file name into an intermediate representation (IR) 
# by inserting semantic tokens. A second transformation step reconstructs the cleaned, standardized
# file name.
#
# Key points:
# • The file name schema is: DATE [IDENTIFIER] LABEL - NAME [SUFFIX]
# • Modular regex components serve as the formal grammar’s production rules.
# • An IR is generated to clearly tag each semantic field.
# • A downstream sed transformation strips the tokens to generate a standard output.
# • GNU Parallel demonstrates how these transformations can be applied concurrently.
#
# This structure is designed so that in the future you can build a parser, generator, or translator
# to automatically produce such scripts from a formal grammar.
# --------------------------------------------------------------------------------------------

# -------------------------------
# Section 0: Setup
# -------------------------------
# Set the target directory containing the files.
target_dir="../"

# List files from the target directory without additional formatting.
file_list=$(ls "$target_dir" --quoting-style literal --color=never)

# -------------------------------
# Section 1: Define Regex Components
# -------------------------------
# File name schema: DATE [IDENTIFIER] LABEL - NAME [SUFFIX]
#   DATE          -> e.g. 2025-03-13 (YYYY-MM-DD)
#   IDENTIFIER    -> e.g. OA-NOTE-009
#   LABEL         -> a single word (alphanumeric)
#   NAME          -> a text string (any characters except a literal dot)
#   SUFFIX        -> optional, typically begins with a dot
date_regex="([0-9]{4}-[0-9]{2}-[0-9]{2})"
identifier_regex="(OA-NOTE-[0-9]{3})"
label_regex="(\\w+)"                # double escapes are required for Bash strings
name_regex="([^\\.$]+)"              # exclude a literal dot and dollar sign
suffix_regex="([\\.]{0,1}[^$]*)\$"    # optional suffix starting with a dot

# -------------------------------
# Section 2: Build the Match Pattern and IR Replacement
# -------------------------------
# Construct the full match pattern by composing the individual regex components.
# The literal characters (spaces, brackets, dash) are included explicitly.
match_pattern="${date_regex}"' \['"${identifier_regex}"'\] '"${label_regex}"' - '"${name_regex}${suffix_regex}"

# The IR replacement defines semantic tokens that prefix each field.
ir_replacement="«DATE» \\1 «IDENTIFIER» \\2 «LABEL» \\3 «NAME» \\4 «SUFFIX» \\5"

# Build the sed substitution: replace the matched file name with its IR.
sed_pattern="s/${match_pattern}/${ir_replacement}/g"

# -------------------------------
# Section 3: Generate the Intermediate Representation (IR)
# -------------------------------
# Process the file list to produce the IR for each file name.
ir_file_list=$(echo "$file_list" | sed -Er "$sed_pattern")

# -------------------------------
# Section 4: Define the Output Grammar & Second Transformation
# -------------------------------
# Now define the tokens and the grammar for IR parsing.
ir_field_value="[^«$]*"  # Matches any characters until encountering a semantic token

# These tokens must match exactly the ones inserted above.
token_date="«DATE»"
token_identifier="«IDENTIFIER»"
token_label="«LABEL»"
token_name="«NAME»"
token_suffix="«SUFFIX»"

# Build the IR pattern that captures the semantic field values.
match_ir_values_regex="${token_date} (${ir_field_value}) ${token_identifier} (${ir_field_value}) ${token_label} (${ir_field_value}) ${token_name} (${ir_field_value}) ${token_suffix} (${ir_field_value})"

# The output replacement reconstructs the file name in the desired format:
# DATE IDENTIFIER LABEL - NAME [SUFFIX]
output_replacement="\\1 \\2 \\3 - \\4\\5"

# Create the sed command to transform the IR back to the final output.
output_sed="s/${match_ir_values_regex}/${output_replacement}/g"

# -------------------------------
# Section 5: Generate the Final Output
# -------------------------------
output_file_list=$(echo "$ir_file_list" | sed -Er "$output_sed")
# Uncomment the following line to see an example transformation:
# echo "$output_file_list" | tail -n 1

# -------------------------------
# Section 6: Batch Processing with GNU Parallel
# -------------------------------
# Export variables so they are available in the subshells spawned by GNU Parallel.
export sed_pattern output_sed

# Use GNU Parallel to process each file entry.
# Note: The --env flag passes the exported variables; --unsafe allows complex operations.
echo "$file_list" | parallel --env sed_pattern,output_sed --unsafe '
  original="{}"
  transformed=$(echo "$original" | sed -Er "$sed_pattern" | sed -Er "$output_sed")
  echo "$original -> $transformed"
'

# End of script
