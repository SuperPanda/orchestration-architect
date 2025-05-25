# **LITERATE SPECIFICATION** for **RETROSPECTIVES**

A **bootstrappable specification** that *implements* the **resources and processes** for **retrospectives**.

> **Document Type**: Literate Specification 

> **Date Created**: 2025-05-09

> **Status**: [**DRAFT-004** WORKING DRAFT](../../../sandbox/OA_PROJECT Sandpit/RETROSPECTIVES.draft-004.md)

> **Resource Identifer**: [oa:specification:xxx](#retrospectives-a-literate-specification)

> **Resource Location**: [**OA PROJECT** SANDBOX](../../sandbox/OA_PROJECT Sandpit.draft-001.md)

> **Resource Name**: **RETROSPECTIVE LIT-SPEC**

## About Literate Specification

    ...TODO: split into literate spec... and the retrospective ...

A **literate specification document** is a *resource* that generates *an implementation* of 
a specification. The **literate specification document** is the *initial object* of a class (category) of resources.

This literate specifications define the both the composition of *objects* within a **retrospective document** and the *objects themselves*.

A **retrospective document** embeds *functionality* to enrich a **retrospective document** as a resources so that 
attempts to overcome a *recurrent* issue or problem can be *reviewed*. 

The *literate specification* is able to be *reorganized* and *rearranged* through *recomposition* due to the ability 
to *rewire* and *recycle* solutions due to the *regenerative* architectural design. 

The use of pre-orders allow for the *recursive* application of abstractions throughout systems of 
systems natural *restructuring* to occur. 

The ability to regenerate allows for extensible future *recomposition*, and by 
using literate writing it not only provides the resources, but binds the *reasoning* 
to the *resource*. So that in the future when we are *required* to *remember* why or how a *resource*
was used to achieve a *result*, it becomes easier to *reuse* *resources* to *rework* (that is, *rewrite*) to
*reach* a *realised* potiential *result*.

The embedded instructions are to aid to *remember* and *redirect* the focus of the participant,
 *reminder*; such that they *refocus* and *reflect* on the previous *resolutions* made. 
This *refreshed* *review* allows a *reprioristisation* of what is the *real* issues that need to be 
*resolved*. 

The *results* being able to *represent* *a retrospective*
that naturally *recommends* the *resources* based on the *reported* *reactions* 
from *reviewing* the previous *retrospective* identified options, *redirects* *resources*, and facilitates 
*reproaching* what *really* bothers us, so *rethink* the issue. 

Also, the positive experiences *reflects* what *resources* leads to *results*. 
The things we *remember* that have a neutral valence still should be *reframed* as the *recall* of 
an experience serves as a heuristic that some *resource* had a *relationship* that 
was *relevant*. The *resolutions* achieved are *reported* if *results* are achieved, and *reconsidered* if not;
to prevent *repeated* *reuse* of *resources*. A *retrospective* allows us to *reshape* *recognised* *resources* to 
become *reliably* *reusable*.

### Getting Started

**Step 1. Bootstrap the Literate Specification**

To initiate the bootstrap process for the **Retrospective Literate Specification**,
run the terminal command:

    cat ./RETROSPECTIVES.md | tail -n1 | sh
  
This will add the `create-retro`, `open-retro` and `set-retro-path` to `$HOME/.local/bin`.

> **Note**: The execution of the bootstrap process will create `$HOME/.local/bin` if it does not exist.
> Also, it will add `$HOME/.local/bin` to the `$PATH` if it does not exist.

> The configuration of `$OA_RETROSPECTIVES_PATH` by `set-retro-path` will be stored in accordance **XDG Base Directory Specification**
> in `$XDG_CONFIG_HOME/orchestration-architect/paths.conf` (which defaults to `$HOME/.config` if not configured).

### The Bootstrap Process

    ...TODO: ... THIS IS A PRELIMINARY PLACEHOLDER FOR THE THE 
             ... lit spec spec, `oa:spec#LIT_SPEC`

```sh «»
cat ./RETROSPECTIVES.md | tail -n1 | sh
```

    ...TODO: PUT THE BOOTSTRAP PROCESS IN


# Specifications

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

```literate «retrospective documents structure»
«Preamble»
«Skeleton for Retrospective Activity»
«Skeleton for Discussion»        
«Skeleton for Review Previous Action Items»
«Literate Instructions for Actionable Items»
```

> **NOTE** The following require *dates* to be added to be inserted into the template (`create-retro` does this).




«Provide Actionable Items Function»
«A bootstrap command on one line... for humans to use to get the thing across»...
```

```md «Preamble»
# Retrospective Journal `«CURRENT DATE»`

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


    ...should work, use a Kan Extension in DEV environments, should store the document in `$XDG_DATA_HOME` for local install default..


---

# Reference Implementation 

### Structure 

Use `m2`? for macros... waiting on literate specificatioon to finish. Still working 
on the `design`... Let's try and track what I got.


The **Bootstrap Specification Command** is required to define the functions 
needed for the *literate bootstrap process*. 

The *literate bootstrap process* should be able to: 

  1. Extract the literate codeblocks

  2. 

  3. Trigger resolution of macros

```sh «BOOTSTRAP RETROSPECTIVE SPECIFICATION»
#!/bin/sh 

# ... create a tool that generates the template from this document ...
# ... and creates an executable script ...
# ... and generates the documents ...
# ... so `create-retro` and `open-retro` ...
# ...`$XDG_BINARY_HOME` path (defaults to `$HOME/.local/bin`)
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

---

## Literate RETROSPECTIVE Documents Execute Document

Run the following command on the file output the documents actionable Items....

```bash
tail -n2 «add   | head -n 1 | sh
``` 
which will call the following:



```bash «RETROSPECTIVE LITERATE TAIL»
grep -P "^>\W\{2}\_\*\*Actionable Item\*\*\_" --after=1 «JOURNAL ENTRY DATE».md
```

---

```md «Skeleton Retrospective Activity»
## Retrospective Activity

**Positive**

__ADD NEUTRAL THOUGHTS AND EXPERIENCES__

**Neutral**

__ADD NEUTRAL THOUGHTS AND EXPERIENCES__

**Negative**

__ADD NEGATIVE THOUGHT AND EXPERIENCES__

```


```md «Skeleton Activity Discussion»
## Discussion

>  *** Discuss responses and identify actionable items. ***



```


```
> **Actionable Item**: ...

    «Retrospective Document Specification»


>    **Actionable Item*
>    Put this somewhere
```
---

# REFERENCE IMPLEMENTATION 

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

```sh «BOOTSTRAP RETROSPECTIVE SPECIFICATION»
sed -e '/^```sh «bootstrap retrospective spec»/,/^```/p' RETROSPECTIVES.md  | cat
