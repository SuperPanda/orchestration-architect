TARGET="../"


FILES="$(ls "$TARGET" --quoting-style literal --color=never)"
# EXAMPLE "$FILES"
# echo "$FILES" | tail -n 1
# 2025-03-13 [OA-NOTE-009] Prototype - Commands to bulk rename to match schema

# PREVIOUS VERSION
#echo "$FILES" | sed -Er 's/([0-9]{4}-[0-9]{2}-[0-9]{2})\ \[(OA-NOTE-[0-9]{3})\]\ (\w+) - ([^\.$]+)[\.]{0,1}([^$]*)$/«DATE» \1 «IDENTIFER» \2 «LABEL» \3 «NAME» \4 «SUFFIX» \5/g'
#IR_FILES="$(echo "$FILES" | sed -Er 's/([0-9]{4}-[0-9]{2}-[0-9]{2})\ \[(OA-NOTE-[0-9]{3})\]\ (\w+) - ([^\.$]+)[\.]{0,1}([^$]*)$/«DATE» \1 «IDENTIFER» \2 «LABEL» \3 «NAME» \4 «SUFFIX» \5/g')"
# EXAMPLE "$IR_FILES"
# echo "$IR_FILES" | tail -n 1
# «DATE» 2025-03-13 «IDENTIFER» OA-NOTE-009 «LABEL» Prototype «NAME» Commands to bulk rename to match schema «SUFFIX» 

DATE_REGEX="([0-9]{4}-[0-9]{2}-[0-9]{2})"
IDENTIFIER_REGEX="(OA-NOTE-[0-9]{3})"
LABEL_REGEX="(\w+)"
NAME_REGEX="([^\.$]+)"
SUFFIX_REGEX="([^$]*)$"
# In order to support grep I will make a grammer later
# grep -oPw 
SPACE=" "
DASH="-"
LBRACKET="["
RBRACKET="]"
SUFFIX_MARKER="[\.]{0,1}"

MATCH_PATTERN=`echo "$DATE_REGEX\ \[$IDENTIFIER_REGEX\]\ $LABEL_REGEX\ -\ $NAME_REGEX[\.]{0,1}$SUFFIX_REGEX"`
# Example
# echo "$MATCH_PATTERN"
# ([0-9]{4}-[0-9]{2}-[0-9]{2})\ \[(OA-NOTE-[0-9]{3})\]\ (\w+)\ -\ ([^\.$]+)[\.]{0,1}([^$]*)$

IR_REPLACEMENT="«DATE»\ \1\ «IDENTIFER»\ \2\ «LABEL»\ \3\ «NAME»\ \4\ «SUFFIX»\ \5"

SED_PATTERN=`echo "s/$MATCH_PATTERN/$IR_REPLACEMENT/g"`
# Example
# echo "$SED_PATTERN"
# s/([0-9]{4}-[0-9]{2}-[0-9]{2})\ \[(OA-NOTE-[0-9]{3})\]\ (\w+)\ -\ ([^\.$]+)[\.]{0,1}([^$]*)$/«DATE»\ \1\ «IDENTIFER»\ \2\ «LABEL»\ \3\ «NAME»\ \4\ «SUFFIX»\ \5/g


IR_FILES=$(echo "$FILES" | sed -Er "$SED_PATTERN")
echo "$IR_FILES"
# Example
#echo "$IR_FILES" | tail -n 1



