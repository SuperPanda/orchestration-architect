# 2025-05-03

## Prototype: Literate Autological Topos

The *code block* below has `«fixture»` appended to the line that marks a beginning of a *code block*:

```«fixture»
start 
abc 
end 
```

The source markup is:

    ```«fixture»
    start 
    abc 
    end 
    ```

**Find a code block**

```sh «basic multiline sed»
search_target="${1:-`echo "2025-05-03.md"`}"   
MATCHED_REGION=$(cat "$search_target" | sed -ne '/^```«fixture»/,/^```$/P')
echo "Matched region:"
echo "$MATCHED_REGION"
```

**Command Output for «basic multiline sed»**

    Matched region:
    ```fixture
    start 
    abc 
    end 
    ```
**Example of the Bug-to-Feature Functor** The code block output needs to be updated when the code block runs.

**Find a literate code block**

```sh «find literate code block»
search_target="2025-05-03.md"
MATCHED_REGION=$(cat "$search_target" | sed -ne '/^```[^«$]*«[^«»$]*»[^$]*$/,/^```$/P')
echo "$MATCHED_REGION"
```

**Literate code block**: a code block that contains an *identified literate
token* appended to a code block start token.

For compositional considerations, we shall assume that it does 
not matter if other things are appended, we will restrict each
*identifiable literate token* to only occur once in the line after the *code block start token*.

The other constraint is that the code block to run begins on the first character, at 
as this allows output and non code block examples of literate code blocks to be included,
as they will use the indented form. 

The `-ne` arguments allow for filtering non-matches and to use extended regex mode.

The command is structured as `/«start pattern»/,/«end pattern»/P`.

The `[^«»$]*` is part I could substitute the code block name.

```sh «find literate code block function»
function find_literate_code_block(){
    local search_target="${1:-`echo 2025-05-03.md`}"   
    MATCHED_REGION=$(cat "$search_target" | sed -ne '/^```[^«$]*«[^«»$]*»[^$]*$/,/^```$/P')
    echo "$MATCHED_REGION"
}

find_literate_code_block
```

**Output of running the `find_literate_code_block` code block**

    ...other results...
    ```sh «find literate code block function»
    function find_literate_code_block(){
        local search_target="${1:-`echo 2025-05-03.md`}"   
        MATCHED_REGION=$(cat "$search_target" | sed -ne '/^```[^«$]*«[^«»$]*»[^$]*$/,/^```$/P')
        echo "$MATCHED_REGION"
    }

    find_literate_code_block
    ```


**The fzf-find-music example from FZF Tools README.md**

I used `:r !cat <path to file in neovim>` to obtain:

    MUSIC_PATH="${1:-$HOME/Music}"
    SELECTED_SONGS=$(fd --type file --glob "**.{mp3,flac}" "$MUSIC_PATH" | tac | fzf-tmux --preview 'ffplay -autoexit -nodisp {}' -p "100%,25%" -x 0 -y 0)
    echo "$SELECTED_SONGS"

However, I notice I need to indent. That would be nice to do automatically.

It would be nice for me to run a neovim command from here, that would allow me 
to save the identified token of the current code block, and replay it with a key bind.

