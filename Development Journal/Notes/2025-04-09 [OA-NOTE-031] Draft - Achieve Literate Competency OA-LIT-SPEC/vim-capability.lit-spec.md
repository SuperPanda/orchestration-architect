# Specification: VIM Capability

**Document Scope**

This document provides an executable literate specification for resources that provide:

  - **a vim session capability** `«vim session capability»`

  - **a vim literate capability** `«vim literate capability»`
      
> **Note**: The `vim literate capability` refers to a `literate writing` capability for vim.


```text
The a `SaveSession` and `LoadSession` capability.
in `oa:capability#vim.SaveSession` and `oa:capability#vim.LoadSession`  .
```

## Synopsis 

**Build `vim.session` (`SaveSession` and `LoadSession`) and `vim.literate` (`ExecuteLine`) Capability**

Trigger the bootstrap with the following command:

```
    **TODO** Find bootstrap implementation, add to literate spec.
```
## Rationale 

The `vim session capability` allows `vim` to `restore session`. 

The `vim session capability` was elicited when an issue in the `nvim` needed to be restarted and `realised` the `potiential` using a `vim session` as a resource.

### Specification

The resource, named `oa:lit-spec#vim`, can be located at `$HOME/.config/orchestration-architect/conf.d/oa.resource.yml`.

#### 

**TODO** NEED TO ADD THE CREATION OF THIS FILE IF IT DOESN'T EXIST NEEDS TO BE MOVED TO `urn:oa-spec:lit

**TODO** Need to put the ideals in, such that i can replace it with my current implementation.

```yml,«oa resource config»
Resource:
  "urn:oa:lit-spec":
    id: "oa:lit-spec"
    label: "OA-LIT-SPEC" 
    name: "Literate Specification"
    location: "$HOME/repos/orchestration-architect/documentation/Development Journal/Specification"
  "urn:oa:tools":   
    id: "oa:tools"
    label: "OA-TOOL"
    name: "Tools"
    location: "$HOMES/repos/"            
  "urn:oa:doc":
    id: "oa:doc"
    label: "OA-DOC"
    name: "Documents"
    location: "$HOME/repos/orchestration-architect/documentation"
```

**TODO** Use the head, tail, grep, sed primitives.

In lieu of a resource resolver, provided is specified fragments.

```yml,«oa resource config»
  "urn:oa:lit-spec#vim.session":
    location: "SPEC
```


The resource `vim session capability` is `realised` by `oa:lit-spec#vim.session`.

The resource `vim session capability` is `actualised` by `oa:tools:vim#session`.

The capability `vim session` capability provides:

  - The `Save VIM Session` capability as a resource

  - The `Load VIM Session` capability as a resource

  - The `Restore VIM Session` emergent capability as a resource.

A `capability` is a `resource`. 

A `emergent capability` is a `capability` that emerges from `actualised resources`.

The reference implementation provides `vim session` capability.

```lit-spec,«vim session tools file»
    «vim session functions»
    «vim literate functions»
```

```vim,«vim session capability»
function! SaveSession()
    " Ensures the sessions directory exists 
    call mkdir(expand('~/.config/nvim/sessions/'), 'p')
    " Save the session 
    execute 'mksession! ~/.config/nvim/sessions/saved_session.vim')
    echom "Session saved!"
endfunction 

function! LoadSession()
    " Source the session file to load it 
    execute 'source ~/.config/nvim/sessions/saved_session.vim'
    echom "Session loaded!"
endfunction
```


```vim,«vim literate capability»
" Binds `execute current line `to `<leader>+r`. 
nnoremap <leader>r :.w bash<CR>
```



## Additional Resources

>   **Non-Normative Reference Material**
>   Marvin Minsky, The Emotion Machine, 2008


## 
**TODO: Literate Reference Implementation should be added**

