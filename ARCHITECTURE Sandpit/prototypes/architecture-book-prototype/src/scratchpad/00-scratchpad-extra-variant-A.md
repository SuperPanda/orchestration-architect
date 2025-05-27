# Task Instruction Template (Proposal A)

---

**Date** 2025-05-26
**Status** Ready

---

```vim «succinct tone» hidden
:'<,'>w !cat | wl-copy; begin; set instructions "Make more salient, clear and succinct"; set data "$(wl-paste | cat)"; terminal-ai (echo -e "$instructions.\n\n$data"); end;
```

## Instructions

### Task

The goal is to make a identify and implement a small change that will: 

> 1. Minimises the difference from the present, and the specified requirements included within the document.

Identify a single high-impact improvement that effectively advances specified requirements with minimal management effort.

> 2. Improve the codebase with respect to coherence, understandability, and composability.

The objective is to enhance understanding of structure and functions by managing complexity through compositionality, thereby reducing cognitive load.

Advice from experience: Effective complex design often results in elegant simplicity. Explore alternatives, consider potential outcomes, and weigh your options carefully.

> 3. Last, but most important, ensure the development is not blocked by broken software. 

If the code is broken, the priority is to make the change to a part that will make small incremental changes.
This is essential so that changes can be verified, because the time is of size one, and it needs to entice people to investigate a new paradigm in system design.


### Format

The response should contain:

* A description of the identified change in relation to the requirements provided within the codebase.
* The reason it was chosen over the other alternatives.
* A description of what is going to be changed.
* A code block containing the original code prior to the change.
* A code block after the modification has been applied.
* A short summary describing how the change has achieved progress in the objectives.
* A conclusion that retrospectively highlights any insights, inspirations, challenges, problems, critiques.

> If the code is broken, the priority is to modify it to an executable state.

> You are expected to think about how things could be changed to make it easier to compose and modify and reason.
> Good design allows complexity to become elegantly simple.

> You are to identify a small region of code to modify that will be presented in a code block,
> and the code after modification in another code block. 

> The comments are to provide information about the code itself that is coherent. 

> You are to identify, which requirement the change will fill. 


>                     ALL INSTRUCTIONS HAVE CONCLUDED FROM THIS POINT
>                        BEGINNING OF CODE TO APPLY INSTRUCTIONS
>                       THE FOLLOWING CONTENT IS THE TARGET TO 
>                           APPLY THE INSTRUCTIONS TOO!

---

## Requirements and Source Code

**File**: `«File Name Placeholder»`

```«File Type Placeholder» «Literate Code Block Identifier Placeholder»
«Source Code Placeholder»
```

---
