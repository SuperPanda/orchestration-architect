# Grammar

Why? To be able to define a grammar for use throughout the system.

These can be converted to regexes and composed easily.

This will allow for specifications for names and labels throughout the system.

For example can use to rename semantic filenames, headers, labels, etc.

The idea is to create a natural transformation between the different parts of the system,
instead of doing layers of filtering, the shortest path is unique, as multiple paths 
that commute, can be represented directly.

Consider the following codeblock:

```peg «parses a codeblock»
backtick            = _{ "" }
codeblock_delimiter =  { backtick ~ backtick ~ backtick }
alpha               = _{ 'a'..'z' | 'A'..'Z' }
space               = _{ " " }
word                = _{ alpha+ }
file_type           =  { word }
token_label         =  { word ~ (space ~ word)? }
literate_token      =  { "«" ~ token_label ~ "»" }
codeblock_metadata  =  { file_type ~ space ~ literate_token }
new_line            = _{ "\n" }
codeblock_start     =  { codeblock_delimiter ~ space? ~ codeblock_metadata ~ new_line }
codeblock_content   =  { (!codeblock_end ~ ANY)* }
codeblock_end       =  { new_line ~ codeblock_delimiter }
codeblock           =  { codeblock_start ~ codeblock_content ~ codeblock_end }
```

It should be able to parse itself.

