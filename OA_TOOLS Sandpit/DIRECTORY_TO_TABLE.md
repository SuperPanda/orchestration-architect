# Directory to Table Command

```
list_notes_results=$(ls -t1 "$HOME/repos/orchestration-architect/documentation/Development Journal/Notes/" -S )
echo "$list_notes_results" | grep -n '^[0-9].*$' | head -n-20 | tail -n+0 | sed -e 's/^\([0-9]*\):/\1,/g' | tabulate -s '\,|\ \[|\]\ |\ -\ ' -f tsv
```
