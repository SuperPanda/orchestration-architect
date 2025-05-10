
# **LITERATE SPECIFICATION** for **RETROSPECTIVES**

A **bootstrappable specification** that *implements* the **resources and processes** for **retrospectives**.

> **Document Type**: Literate Specification 

> **Date Created**: 2025-05-09

> **Status**: [**DRAFT-002** WORKING DRAFT](<../../sandbox/OA_PROJECT Sandpit.draft-002.md>)

> **Resource Identifer**: [oa:specification:xxx](#retrospectives-a-literate-specification)

> **Resource Location**: [**OA PROJECT** SANDBOX](../../sandbox/OA_PROJECT Sandpit.draft-001.md)

> **Resource Name**: **RETROSPECTIVE LIT-SPEC**


## About Literate Specification

A *literate specification* is a document 
that can provide *an implementation* of 
*a specification*.

This literate specifications *implements* the *generation* of **retrospective documents** that facilite activities which capture _actionable potiential resources_ for *continuous improvements* processes.

### Getting Started

**Step 1. Bootstrap the Literate Specification**

To initiate the bootstrap process for the **Retrospective Literate Specification**,
run the terminal command:

    tail -n1 "RETROSPECTIVES.md" | sh
  
This will add the `create-retro`, `open-retro` and `set-retro-path` to `$HOME/.local/bin`.

> **Note**: The execution of the bootstrap process will create `$HOME/.local/bin` if it does not exist.
> Also, it will add `$HOME/.local/bin` to the `$PATH` if it does not exist.

> The configuration of `$OA_RETROSPECTIVES_PATH` by `set-retro-path` will be stored in accordance **XDG Base Directory Specification** in `$XDG_CONFIG_HOME/orchestration-architect/paths.conf` (which defaults to `$HOME/.config` if not configured).

### Bootstrap Process

The command `tail -n "RETROSPECTIVES.md"` should work, use a Kan Extension in DEV environments, should store the document in `$XDG_DATA_HOME` for local install default...


## Specifications

A new retrospective can be created by running `create-retro`
from the terminal.

The `create-retro` command creates a 
**RETROSPECTIVE DOCUMENT** that implements 
the specified template. If a retrospective 
already exists for the current day,
it will open the existing retrospective.

> **NOTE** The `create-retro` is used to **initiate** a retrospective.

The `open-retro` command opens the 
most recent retrospective.

### The Structure of a Retrospective Document

The markdown is structured as follows:

```md «Composition of Retrospective Document»
«Preamble»
«Skeleton for Retrospective Activity»
«Skeleton for Discussion»        
«Skeleton for Review Previous Action Items»
«Literate Instructions for Actionable Items»
```

    **NOTE** TODO ADD GRAMMAR: PEG «GRAMMAR»


> **NOTE** The following require *dates* to be added to be inserted into the template (`create-retro` does this).
>          File name 


«Provide Actionable Items Function»
«A bootstrap command on one line... for humans to use to get the thing across»...
```

```md «Preamble»
# 

```

    **TODO** WILL NEED TO SET THIS UP AND VERIFY THE OA-LITERATE TOOLS MATCH REFERNECE IMPLEMENTATION 


```sh «open-retro»
# ...NEEDS TO FIND THE LATEST RETRO AND OPEN IT ...
# ...WONT CREATE ONE IF NONE IS AVAILABLE...
```

```sh «create-retro»
....
```

... THIS ARE TO BE BUILT AND STORED IN `$HOME/.local/bin` and `Added to path`.
... 


**Functional**
```
    «Retrospective Operations»
        «Create New Retrospective from Skeleton»
        «Locate Previous Retrospective»
        «Import Previous 'Actionable Items' as 'Review Items'»
```

### Document Components

The document fragments specify the literate 
elements of the document.

**Component: ACTIONABLE ITEM**

An *actionable item* is an action that *COULD* 
be undertaken.

```md «Actionable Item Fragment»
>  **Actionable Item**: __REPLACE WITH ACTIONABLE ITEM__
```

**Component: REVIEW ITEM**

A *review item* is an *actionable item* from a previous
retrospective. This *SHOULD* come from 
the most recent *retrospective* prior 
to the current one.

The *review item* is used to track if any 
action was taken and any notes (or the 
reason no action was taken). 

```md «Review Previous Item Fragment»
> **Review Item**: «AN ACTIONABLE ITEM FROM LAST RETROSPECTIVE»
```

### Configuration

Any *review items* that want to be kept, 
*SHOULD* be added as a new *actionable item*
to the current retrospective.

**Environment Variables**

*Retrospective Documents Location*: `$OA_RETROSPECTIVE_PATH`

**TODO** Await for CONFIGURATION Specifications

**TODO** Add a `$OA_RETROSPECTIVES_PATH` environment
         variable to set the destination of the documents,
         inside `$OA_CONFIG_PATH `$XDG_CONFIG_HOME/orchestration-architect/config`.




---

# Reference Implementation 

### Structure 

Use `m2`? for macros... waiting on literate specificatioon to finish. Still working 
on the `design`... Let's try and track what I got.

```sh «bootstrap retrospective spec»
#!/bin/sh 

... create a tool that generates the template from this document ...
... and creates an executable script ...
... and generates the documents ...
... so `create-retro` and `open-retro` ...
...`$XDG_BINARY_HOME` path (defaults to `$HOME/.local/bin`)
```


### Planned work 

... LITERATE SPEC 001 - SHOULD CREATE THIS DOCUMENT ...
... AND ENRICH THE WAY OF COMPOSING THINGS ...

... THE SETUP AND CONFIGURATION SPEC ...
... WILL BE MANAGED BY THE CONFIGURATION SPECIFICATION ...
... WHICH WILL BE DESIGNED TO INTEGRATE WITH SHELL ENVIRONMENT AUTOMATICALLY ...

and is designed to 
bootstrap tools to automate 
to create to generate 

THIS FRAGMENT IS ADDED TO END OF EACH DOCUMENT SUCH THATS EACH DOCUMENT CAN LIST ITS OWN ACTIONABLE ITEMS.

WHICH WILL CAN BE APPENDED TO THE NEXT DOCUMENT.



## Execute Document

Run the following command on the file to see all the action items.

```bash
tail -n2 «add   | head -n 1 | sh
---

which will call the following:

```bash
grep -P "^>\W{1,8}\_\*\*Actionable\*\*\_" --after=1 $HOME/Documents/Orchestration\ Architect/Retrospectives/2025-02-14.md
```



---

## Retrospective Activity

**Positive**

__ADD NEUTRAL THOUGHTS AND EXPERIENCES__

**Neutral**

__ADD NEUTRAL THOUGHTS AND EXPERIENCES__

**Negative**

__ADD NEGATIVE THOUGHT AND EXPERIENCES__


## Discussion

    *** Discuss responses and identify actionable items. ***



> **Actionable Item**: ...

    «Retrospective Document Specification»


>    **Actionable Item*
>    Put this somewhere


---

md «RETROSPECTIVE DOCUMENT REFERENCE IMPLEMENTATION»

# Retrospective Journal `«CURRENT DATE»`

## Retrospective Activity

**Positive**

> *** ADD POSITIVE THOUGHTS AND EXPERIENCES BELOW ***



**Neutral**

> *** ADD NEUTRAL THOUGHTS AND EXPERIENCES BELOW ***



**Negative**

> *** NEGATIVE THOUGHTS AND EXPERIENCES BELOW ***


## Discussion

    Discuss the retrospective activity responses 
     and identify actionable items (see below).   
      
--- 


```
sed '/```sh «bootstrap literate spec»/,/^```/' RETROSPECTIVES.md  | bash
