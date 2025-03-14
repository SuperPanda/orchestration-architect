# Test should work by commenting all the lines starting with echo and then uncommenting the test to see if it matches
TARGET="../"


FILES=$(ls "$TARGET" --quoting-style literal --color=never)
# EXAMPLE "$FILES"
# echo "$FILES" | tail -n 1
# 2025-03-13 [OA-NOTE-009] Prototype - Commands to bulk rename to match schema

# PROTOTYPE
#echo "$FILES" | sed -Er 's/([0-9]{4}-[0-9]{2}-[0-9]{2})\ \[(OA-NOTE-[0-9]{3})\]\ (\w+) - ([^\.$]+)[\.]{0,1}([^$]*)$/«DATE» \1 «IDENTIFER» \2 «LABEL» \3 «NAME» \4 «SUFFIX» \5/g'
#IR_FILES="$(echo "$FILES" | sed -Er 's/([0-9]{4}-[0-9]{2}-[0-9]{2})\ \[(OA-NOTE-[0-9]{3})\]\ (\w+) - ([^\.$]+)[\.]{0,1}([^$]*)$/«DATE» \1 «IDENTIFER» \2 «LABEL» \3 «NAME» \4 «SUFFIX» \5/g')"
# EXAMPLE "$IR_FILES"
# echo "$IR_FILES" | tail -n 1
# «DATE» 2025-03-13 «IDENTIFER» OA-NOTE-009 «LABEL» Prototype «NAME» Commands to bulk rename to match schema «SUFFIX» 

DATE_REGEX="([0-9]{4}-[0-9]{2}-[0-9]{2})"
IDENTIFIER_REGEX="(OA-NOTE-[0-9]{3})"
LABEL_REGEX="(\w+)"
NAME_REGEX="([^\.$]+)"
SUFFIX_REGEX="([\.]{0,1}[^$]*)$"
# In order to support grep I will make a grammer later
# The grammar can be used for parsing and generating other forms of code
# grep -oPw 
# SPACE=" "
# DASH="-"
# LBRACKET="["
# RBRACKET="]"
# SUFFIX_MARKER="[\.]{0,1}"
# BACKSLASH="\"
# OPTIONS_START="$BACKSLASH$LBRACKET"
# OPTIONS_END="$BACKSLASH$RBRACKET"
# ESCAPED_SPACE="$BACKSLASH$SPACE"
# DOLLAR="$"


MATCH_PATTERN=`echo "$DATE_REGEX\ \[$IDENTIFIER_REGEX\]\ $LABEL_REGEX\ -\ $NAME_REGEX$SUFFIX_REGEX"`
# Example
# echo "$MATCH_PATTERN"
# ([0-9]{4}-[0-9]{2}-[0-9]{2})\ \[(OA-NOTE-[0-9]{3})\]\ (\w+)\ -\ ([^\.$]+)[\.]{0,1}([^$]*)$

IR_REPLACEMENT="«DATE»\ \1\ «IDENTIFIER»\ \2\ «LABEL»\ \3\ «NAME»\ \4\ «SUFFIX»\ \5"

SED_PATTERN=`echo "s/$MATCH_PATTERN/$IR_REPLACEMENT/g"`
# Example
# echo "$SED_PATTERN"
# s/([0-9]{4}-[0-9]{2}-[0-9]{2})\ \[(OA-NOTE-[0-9]{3})\]\ (\w+)\ -\ ([^\.$]+)[\.]{0,1}([^$]*)$/«DATE»\ \1\ «IDENTIFER»\ \2\ «LABEL»\ \3\ «NAME»\ \4\ «SUFFIX»\ \5/g


IR_FILES=$(echo "$FILES" | sed -Er "$SED_PATTERN")
# Example
# echo "$IR_FILES" | tail -n 1
# «DATE» 2025-03-13 «IDENTIFER» OA-NOTE-009 «LABEL» Prototype «NAME» Using Intermediate Representation for Semantic Renaming of Files «SUFFIX» 

# For simplicity take i will finish now
IR_FIELD_VALUE=`echo "[^«$]*"`
DATE_FIELD=`echo "«DATE»"`
IDENTIFIER_FIELD=`echo "«IDENTIFIER»"`
LABEL_FIELD=`echo "«LABEL»"`
NAME_FIELD=`echo "«NAME»"`
SUFFIX_FIELD=`echo "«SUFFIX»"`
# Need to check for whitespace issues later
# also need to put the dot back (think it will work as i added the dot field to the suffix pattern)
MATCH_IR_VALUES_REGEX=`echo "$DATE_FIELD\ ($IR_FIELD_VALUE)\ $IDENTIFIER_FIELD\ ($IR_FIELD_VALUE)\ $LABEL_FIELD\ ($IR_FIELD_VALUE)\ $NAME_FIELD\ ($IR_FIELD_VALUE)\ $SUFFIX_FIELD\ ($IR_FIELD_VALUE)"`

REPLACE_IR="\1\ \2\ \3 - \4\5"
OUTPUT_SED="s/$MATCH_IR_VALUES_REGEX/$REPLACE_IR/g"
# Example 
# echo "$OUTPUT_SED" | tail -n 1
# s/«DATE»\ ([^«$]*)\ «IDENTIFIER»\ ([^«$]*)\ «LABEL»\ ([^«$]*)\ «NAME»\ ([^«$]*)\ «SUFFIX»\ ([^«$]*)/\1\ \2\ \3 - \4\5/g

OUTPUT_FILES=$(echo "$IR_FILES" | sed -Er "$OUTPUT_SED")
# Example 
# echo "$OUTPUT_FILES" | tail -n 1
# 2025-03-13 OA-NOTE-009 Prototype - Using Intermediate Representation for Semantic Renaming of Files


#IR_FILES=$(echo "$FILES" | sed -Er "$SED_PATTERN")


# Previous attempts
#echo "$FILES" | parallel --unsafe echo "{}" <<< $(cat <<< $(sed -Er "$SED_PATTERN") <<< $(sed -Er "$OUTPUT_SED"))
#COMPOSED_CMD="sed -Er '$SED_PATTERN' | sed -Er '$OUTPUT_SED'"
#echo "$FILES" | parallel --unsafe echo <<< $(sed -Er "$SED_PATTERN" | sed -Er "$OUTPUT_SED")

# AI was used for the next bit 
## HOW DO I MAKE THIS SO I CAN echo "{}" "sed_ir to sed_output"

# Export variables to make them available in the subshell
export SED_PATTERN OUTPUT_SED

# Now run parallel with proper variable expansion
echo "$FILES" | parallel --unsafe 'original="{}"; transformed=$(echo "$original" | sed -Er "$SED_PATTERN" | sed -Er "$OUTPUT_SED"); echo "$original -> $transformed"'
