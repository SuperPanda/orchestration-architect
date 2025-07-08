# Literate Spec: LIT_SPEC_TEMPLATE

**Tags**: #LiterateSpec #quality
**File Name**: `LIT_SPEC LIT_SPEC_TEMPLATE.md`
**Last Updated**: 2025-07-08

## Synopsis

> **Generate a Literate Specification**: 

    tail -n1 "LIT_SPEC LIT_SPEC_TEMPLATE.md" | sh -1

> **Tip**: To run in vim run `:w !cat | tail -n 1 | sh -`
> 	 or [see appendix to bind key to execute](#Embedded Development Tool (Neovim))
>

**This document is enriched with a literate capability**
## Introduction

This is where the document begins. Here is a code block that will run to ensure everything is just dandy.

```sh «execution block»
sanity_check=$(get_literate_codeblock "SaNiTy ChEck")
run_command "$sanity_check"
```

> **Note**: Replace the `LIT_SPEC_TEMPLATE` with the filename, such that it is `./LIT_SPEC «REPLACEMENT FOR LIT_SPEC_TEMPLATE».md`.





## Appendix: Literate Document Enrichment

### Sanity checks

```sh «SaNiTy ChEck»
#!/bin/sh
echo "Hello, World!"
seq 1 10 | xargs printf "%0.3d "
```

### Literate Tooling

```sh «literate tools»
file_content=$(find . -name "LIT_SPEC LIT_SPEC_TEMPLATE.md" -exec cat {} +)
get_literate_codeblock() {
    local token_name="$1"
    sed -n "/^\`\`\`[^«]*«$token_name»\$/,/^\`\`\`\$/ {/^\`\`\`/d;p}" <<< "$file_content"
}

run_command(){
    local command="$1"
    cat <<< $(echo "$command" | sh -)
}
```

### Bootstrap Entry Point

```sh «bootstrap entrypoint»
read_file(){
    find . -name "LIT_SPEC LIT_SPEC_TEMPLATE.md" -exec cat {} +
}

literate_tools=$(read_file | sed -n '/^```[^«]*«literate tools»$/,/^```$/{/^```/d;p}')
execution_block=$(read_file | sed -n '/^```[^«]*«execution block»$/,/^```$/{/^```/d;p}')
echo -e "$literate_tools\n$execution_block" | sh -

```

### Embedded Development Tool (Neovim)

Bootstrap the Neovim literate tool by pressing `<Shift>` and `V` over the code block below,
to visually select the `init` function and `init()` method and type `:lua`.

This snippet will register the user command 'LitExec' in neovim for this document and triggered 
with `\` followed by `<Tab>`.

```lua «Literate Tools for Neovim»
function init()
    function execute()
        cmd = 'w !tail -n1 | sh -'
        print "Registered execute command."
        return function() vim.cmd(cmd) end
    end
    vim.api.nvim_create_user_command('LitExec', execute(),{})
    vim.keymap.set('n','\\<Tab>',':LitExec<CR>')
end
init()
```

### How to execute this document

By running `tail -n 1 | sh -` on this document, the 
document will generate a reference implementation of this specification.

It will call the following command located in [Bootstrap Entry Point](#Bootstrap Entry Point).

     echo "$(find . -name "LIT_SPEC LIT_SPEC_TEMPLATE.md" -exec cat {} +)" | sed -n '/^```sh «bootstrap entrypoint»$/,/^```$/{/^```/d;p}' | sh -