# Line numbered grepping with SED 

## How to output a file with SED
```sh,«get line numbered match»
#!/bin/sh 
FILE="$1"
MATCH_PATTERN="$2"
local sed_pattern="/$MATCH_PATTERN/p"
cat "$FILE" --number | sed -ne "$sed_pattern"
```

## Find the macros
```sh,[«find macros»]⇒
THIS_FILE="2025-03-20 [OA-NOTE-020] Command - Line numbered grepping With Sed.md"
cat "$THIS_FILE" --number | sed -ne '/[«[^»]*»\]⇒$/p' | grep -oP "«.*»"
cat "$THIS_FILE" --number | sed -ne '/[«[^»]*»\]⇒$/p' | cut -f1
```

## This returns everything below
```sh,[«find patterns»]⇒
#!/bin/bash
THIS_FILE="2025-03-20 [OA-NOTE-020] Command - Line numbered grepping With Sed.md"
MATCH_PATTERN="/[«find patterns»]⇒$/,/\`\`\`/p"
cat "$THIS_FILE" --number | sed -ne "$MATCH_PATTERN" | cut -f2 | tail -n+2 | head -n-1
```
