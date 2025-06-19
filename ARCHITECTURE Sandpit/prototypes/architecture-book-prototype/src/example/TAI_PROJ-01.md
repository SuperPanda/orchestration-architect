# Terminal AI Project: Build Documentation Subsystem

## 1. Generate Tasks 

### Prepare Template 


> **human bit**
```lua «run literate block»
vim.api.nvim_command(":w !sed -nE '/^```sh «find codeblocks»$/,/^```$/p' | head -n-2 | tail -n-1")
vim.api.nvim_command(": !wl-paste | bash")
-- setup read run output command.
```

**Prepare Reference Sample**

```sh «find codeblocks»
#/bin/sh
FILE="../architecture-book-prototype/src/example/00-tai-design.md"
start=`cat $FILE | grep -nP "##" | cut -f1 -d: | head -n 1`
end=`cat $FILE | grep -nP '^---' | cut -f1 -d: | tail -n-2 | head -n1`
# echo "$start"
# echo "$end"
cat "$FILE" | head -n+$end | tail -n+$start > /tmp/reference-task.md
```
```
```


## Reference task to adapt

```
<!-- cmdrun cat /tmp/reference-task.md -->
```

> # cat "$FILE" | sed -E '/^```/,/^```$/p'
