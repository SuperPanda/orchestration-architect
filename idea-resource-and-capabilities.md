# IDEA-002 The Resource-Capability Duality

    **Title**: The `Resource-Capability Duality`
    **Description**: Focus Development with Capability Directed Development
    **Tags**: #Capability #Competency #Resourcefulness
    **Created**: 10/04/2025
    **Identifier**: IDEA-002
    **Related Resources**:


- [OA-PROJECT.LIT-SPEC](../Projects/Kanban/LIT-SPEC Self-Bootstrap Literate Specifications.md)
        

## Rationale 

To distill the abstract structure needed to promote compositional coherence, it is best to start with the ideal structure to begin with, this will distill the potential capabilities. 

This will allow a targeted approach to some domain.

Aim for the most simple model but no simpler such that it defines each item by its interactions (morphisms). 

```
---resource A.partA--[ ACTION 1 ]--[ACTION 2]---resource B---
---resource A.partB---------------^           |_resource A---
```

This could be simplified to 


```
--resource A--[NEW ACTION]--resource A-- 
                           |_resource B---
```

the structures must be able to generate models of a process, 
and it should cohere across various bodies of knowledge (SWEBOK, PMBOK, ... ). The process can be introspected, to provide a way to perform this distillation
more generally. Demonstration of a coherent structure, is that the morphisms between objects, should dually allow object-free constructions, 
where the objects are defined by context.

Memory needs to be braided with goals to point to resource

### Capability and Specifications 

The aim of the development journal is to create a framework that:

- designed to support universal construction of a realised potiential as a note/idea 
- and the note/idea is an accessible resources to create a realisation->actualise mapping, so that when realisation is fully realised, then it automatically is actualised.

To generate capabilities that achieve natural coherence, there needs to be like a tree-like functor map into a resource (optics category)

The ability to actualise capabilities is a competency. 


```
COMPETENCY MODEL

                         [Capability VIEW]                           
 
"potiential capabilities" ---> "realised capabilities" ---> "actualised capabilities"
                            /\                          /\       
                           /  \                        /  \   
and its dual                ||                          ||   
                            ||                          ||                         
                           \  /                        \  /   
                            \/                          \/        
                realise capablities -------> actualise capabilities 

                        [Competency VIEW]

```

In the comptency model proposed, the actualised capabilities become resources.

Aim defined as the application of resources to minimise the difference between the current state, and the realised potientialities state

A project/program has an 'aim' or 'objective' that combines resources to achieve (actualise) the realised potiential. 

```
---[capture identified capabilities]---[build the capability]----
|                                  |                         |
potiential_capabilities         realised_capabilities    actualised_capability
 ```

Anything that can exist means it the potential to exist.
Anything that exists, had the potiential to exist.

When one realises a potential capability, it turns `potiential -> (potential, realisation of potential)`

When one identifies the a realised potiential will achieve some end, then actualisation:

```
--- realised potential --- actualised potential ----
                       --- remaining potiential ----
```

The remaining potiential turns back into potiential. so potential splits off, as the realisation is discarded when invoked.

Capabilities could be `ability to make a resource availabile on demand`.

```
RESOURCEFULNESS MODEL 

                |  
                | potential resource: something that can be put together from available resources 
                |
         [-------------]                                                                                                             
         [  realise    ]                                                                                                                       
         [ potiential  ] 
         [  resource   ]                                                                                                                         
         [-------------] 
                |
                | realised potiential resource: a means to the available resource 

realised potiential is unique up to isomorphisms, from the requirements elicitation stage and development 

actualised potiential is the resource provided that can be used with other resources. 
```


# A VIM Capability Design Sketch

## Specification: VIM Capability

**Document Scope**

This document provides an executable literate specification for resources that provide:

  - **a vim session capability** `«vim session capability»`

  - **a vim literate capability** `«vim literate capability»`
      
> **Note**: The `vim literate capability` refers to a `literate writing` capability for vim.


```text
The a `SaveSession` and `LoadSession` capability.
in `oa:capability#vim.SaveSession` and `oa:capability#vim.LoadSession`  .
```

### Synopsis 

**Build `vim.session` (`SaveSession` and `LoadSession`) and `vim.literate` (`ExecuteLine`) Capability**

Trigger the bootstrap with the following command:

```
    **TODO** Find bootstrap implementation, add to literate spec.
```
### Rationale 

The `vim session capability` allows `vim` to `restore session`. 

The `vim session capability` was elicited when an issue in the `nvim` needed to be restarted and `realised` the `potiential` using a `vim session` as a resource.

### Specification

The resource, named `oa:lit-spec#vim`, can be located at `$HOME/.config/orchestration-architect/conf.d/oa.resource.yml`.

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


