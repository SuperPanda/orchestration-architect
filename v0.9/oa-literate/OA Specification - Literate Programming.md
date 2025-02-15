# OA Specification: Literate Documents
# OcatA Specification: Literate Documents

## Introduction

Literate Programming in Orchestration Architect is a way to write documents that generate te code needed to execute in clear, consistent and composable way.

This ensures that documentation drift is avoided, by making the documentation a first class system. This ensures that all parts of the system have a way of having a clear structure and aims to provide a means of facilitating composable and consistent documentation and reproducibility.

## Syntax

**Macro**

Macros are identified by the `«` and `»` symbols surrounding the label of the macro `«macro»` starting at the beginning of the line, with the body of the macro being indented until the `@` is found.

    «macro»
        «sections to include»
        @


The `«sections to include»` are can be other macros, content or both.
    

**Macro Scopes**

The `Macro Scope` is defined by a scope being assigned to the comment region. The scope of a macro is defined using appending `scope: <FILE>[,<ANOTHER_FILE>[...]]`code block.

The following example scopes `«macro1»` to `fileA` and `fileB`, and whereas `«macro2»` is global.

    ```scope: fileA,fileB
    «macro1»
        ...
    ```
In this example, `«macro1»` is scoped to fileA and fileB, while `«macro2»` has a global scope. The scopes allow for generic common structures to be used for consistent structure, but independent implementations.

```WIP
Grammar...
Generate / Production Rules
Parse / Regex
... 


## Concepts

### Pre-orders

Pre-orders ensure that structural order is preserved under operations, guaranteeing that operations do not alter the order of elements or modify content unexpectedly.

An example is seen with nested macros, where enumerating (parent, child) pairs enables a topological sort. This allows macros with no dependencies to be rendered by concatenating instances within the file scope, storing the chunk for later use. When processing parent macros, only concatenation is required.

``` REWORK IN PROGRESS
Given a region, deterministic extraction is achieved using by getting take everything before the end, and when everything after the start region.
....before the end and/or taking after the start. 
...by filtering to the taking the top  by the end line number, then removing everything before the start line number.
`head -n+(end) | tail -n+(start)`, 
```
«obtain region boundaries»
    «identify region»   | ADD TO FUCTIONS
    ªtake until the end»    | ADD TO
    «remove until the start»| ...OPERATIONS 

```
Given a region, deterministic extraction is achieved using `head -n+(end) | tail -n+(start)`, selecting regions by filtering to the last line by the end line number, then removing everything before the start line number.

    
«»
```


The composition of `concat`, `grep` (to identify line numbers and extract content), and other operations ensures consistency in `embed`, `extract`, and `compose` operations, preserving content integrity by not changing the content or order.

This abstract pattern also applies to hierarchies like document outlines based on header levels, enabling documents to generate relationships and semantic context. A specification file with this structure can generate components and produce reports based on its internal structure, without requiring implementation knowledge.

When declaring the same macro multiple times, its contents are concatenated. To preserve operation order, use a macro for files to be included. Alternatively, declare separate macros for different functionalities, combining them into the «functions» macro under the Operation section.

### Monoidal Category (WIP)
n the context of literate orchestration, our structure forms a monoidal category where the objects are line numbers, macros, and scopes, and the morphisms represent the transformations between these objects.

A monoidal category consists of:

    A bifunctor: A composition operation ⊗:C×C→C⊗:C×C→C that defines how macros and their contents combine. In our case, this bifunctor corresponds to concatenation of macros, preserving their structural order.
    Left and right identity elements: These are the minimal structures needed to ensure proper composition. We define:
        The left identity as the start of a region.
        The right identity as the end of a region.
        These correspond to the head-tail extraction operation extract(head,tail)extract(head,tail), ensuring regions are correctly delimited.
    Associativity: The combination of macros follows an associative law, meaning that reordering nested macro evaluations does not affect the output. This guarantees that:
    (macro1⊗macro2)⊗macro3=macro1⊗(macro2⊗macro3)
    (macro1​⊗macro2​)⊗macro3​=macro1​⊗(macro2​⊗macro3​) This follows naturally from how macro concatenation works.
    Coherence conditions: The monoidal structure respects natural transformations between different ways of grouping macros. Since macros map naturally to regions in the document (i.e., line number segments), and regions map to concatenated outputs, we establish that macros behave functorially.

Functoriality and the Yoneda Lemma

By the Yoneda Lemma, objects are characterized by their morphisms. Since:

    Line numbers correspond to extracted content.
    Macros correspond to structured compositions of content.
    Scopes define contextual groupings for evaluation.

It follows that the morphisms between these structures (extraction, composition, and embedding operations) fully determine their behavior. Thus, macros and regions behave as functors, preserving structure across transformations.
Commutativity and Preorder Structure

The preorder structure of macros ensures a commutative diagram, particularly when composing program sections such as:
(P×V×F×E)→(P×V)×(F×E)→P×(V×F)×E→(P×V×F×E)
(P×V×F×E)→(P×V)×(F×E)→P×(V×F)×E→(P×V×F×E)

Where:

    PP = Preamble
    VV = Variables
    FF = Functions
    EE = Entry Point

This ensures that program composition maintains structural integrity across different transformations. Since macro scopes introduce natural ways to rearrange program structure while preserving the preorder constraints, they enable commutative transformations, allowing flexible reordering without affecting execution.

Thus, our literate orchestration system naturally forms a monoidal category, with a well-defined bifunctorial composition, identity elements, and associativity, making it a robust framework for composable and verifiable document-based programming.
## Example (WIP)

Programs will be built by tangle the web of macros to produce source code.

The weave program will generate a literate document from existing files and write to weave `.weave/`.

```scope: oa-literate-weave

```


If `.weave/manifest` file does not exist it will search the directory for all files not in the .gitignore files.

```file: ./oa-literate-weave


```

The tangle literate writing program will combine all the macros through this document and combine them, and output within the `.tangle/` subdirectory.

```file: ./oa-literate-tangle,./oa-literate-weave
«program»
    «preamble»
    «variables»
    «functions»
    «entry point
    @
```

The tangle prgram will identify line numbers with any `«macro name»` beginning at the start of the line, and all the indented `@` and fine the boundaries of the region.

If a file is specified in the line before a tripe backtrip before it will scope the concatenation of the macros values to the file separately.


The preamble will hold the interpreter and file metadata:
```file: oa-literate-tangle
«preamble»
    #!/bin/sh
    # Literate tangle program - Generates executable code from a literate document
    @
```

## Operations (WIP)

In order to ensure correctness and compatibility will restrict the operations to operations `concat` and `tail`, `head`, `sed` and `grep`.


```
«function to locate macro regions»

    function locate_macro_regions(){
        ... 
    }

```

### Identity
```
«get macro boundary»
    function get_boundary_positions(){
    
}

```
```



**Skeleton**
A skeleton is a scaffold placeholders for the regions to be embedded. 



## 

## Validate Output


The following program will generate a program to build the literate program.

```




```
«
«Uniquely Identifiable Boundary Mark»
«»

```

## Introduction

Literate Programming in Orchestration Architect is a way to write documents that generate te code needed to execute in clear, consistent and composable way.

This ensures that documentation drift is avoided, by making the documentation a first class system. This ensures that all parts of the system have a way of having a clear structure and aims to provide a means of facilitating composable and consistent documentation and reproducibility.

## Syntax

**Macro**

Macros are identified by the `«` and `»` symbols surrounding the label of the macro `«macro»` starting at the beginning of the line, with the body of the macro being indented until the `@` is found.

    «macro»
        «sections to include»
        @


The `«sections to include»` are can be other macros, content or both.
    

**Macro Scopes**

The `Macro Scope` is defined by a scope being assigned to the comment region. The scope of a macro is defined using appending `scope: <FILE>[,<ANOTHER_FILE>[...]]`code block.

The following example scopes `«macro1»` to `fileA` and `fileB`, and whereas `«macro2»` is global.

    ```scope: fileA,fileB
    «macro1»
        ...
    ```
In this example, `«macro1»` is scoped to fileA and fileB, while `«macro2»` has a global scope. The scopes allow for generic common structures to be used for consistent structure, but independent implementations.


## Concepts

### Pre-orders

Pre-orders ensure that structural order is preserved under operations, guaranteeing that operations do not alter the order of elements or modify content unexpectedly.

An example is seen with nested macros, where enumerating (parent, child) pairs enables a topological sort. This allows macros with no dependencies to be rendered by concatenating instances within the file scope, storing the chunk for later use. When processing parent macros, only concatenation is required.

Deterministic extraction is achieved using `head -n+(end) | tail -n+(start)`, selecting regions by filtering to the last line by the end line number, then removing everything before the start line number.

The composition of `concat`, `grep` (to identify line numbers and extract content), and other operations ensures consistency in `embed`, `extract`, and `compose` operations, preserving content integrity by not changing the content or order.

This abstract pattern also applies to hierarchies like document outlines based on header levels, enabling documents to generate relationships and semantic context. A specification file with this structure can generate components and produce reports based on its internal structure, without requiring implementation knowledge.

When declaring the same macro multiple times, its contents are concatenated. To preserve operation order, use a macro for files to be included. Alternatively, declare separate macros for different functionalities, combining them into the «functions» macro under the Operation section.

### Monoidal Category (WIP)
... Consits of a bifunctor, where a bifunctor (C) x (C) -> the monoiod prduct, a left and right identity... (start) and (end), coherence condition associativity of composition.... natural transformation ensuring the line nnumbers, regions extracted using the extract(head,tail) operation (line number) from the operations the resulting chunks we will call regions, and the macros which concat and selects regions, are all the same category up to natural isomoprhism... since regions have natural mapping to the line numbers, and macros have natural mapping to the regions, therefore the operations are isomorphic to functors. So the Yoneda lemma says we define an object by its morphisms, and if you know all the morphisms, the the objects in this category are line numbers, macros, and scope.
... Explain that by using this we get natural transformations allowing the swapping, as seen by the scope ... 
... verify if that due to the preorder, it is guarenteed that the commutative pentagon holds, as (preamble, variables, functions, entry poiont) commutes due (C x V x F x E) -> (C x V) x (F x E) -> C x (V x F) x E -> (C x V x F x E) ...
```
«program»
    «preamble»
    «variables»
    «functions»
    «entry point
    @
```

## Example (WIP)

Programs will be built by tangle the web of macros to produce source code.

The weave program will generate a literate document from existing files and write to weave `.weave/`.

```scope: oa-literate-weave

```


If `.weave/manifest` file does not exist it will search the directory for all files not in the .gitignore files.

```file: ./oa-literate-weave


```

The tangle literate writing program will combine all the macros through this document and combine them, and output within the `.tangle/` subdirectory.

```file: ./oa-literate-tangle,./oa-literate-weave
«program»
    «preamble»
    «variables»
    «functions»
    «entry point
    @
```

The tangle prgram will identify line numbers with any `«macro name»` beginning at the start of the line, and all the indented `@` and fine the boundaries of the region.

If a file is specified in the line before a tripe backtrip before it will scope the concatenation of the macros values to the file separately.


The preamble will hold the interpreter and file metadata:
```file: oa-literate-tangle
«preamble»
    #!/bin/sh
    # Literate tangle program - Generates executable code from a literate document
    @
```

## Operations (WIP)

In order to ensure correctness and compatibility will restrict the operations to operations `concat` and `tail`, `head`, `sed` and `grep`.


```
«function to locate macro regions»

    function locate_macro_regions(){
        ... 
    }

```

### Identity
```
«get macro boundary»
    function get_boundary_positions(){
    
}

```
```



**Skeleton**
A skeleton is a scaffold placeholders for the regions to be embedded. 



## 

## Validate Output


The following program will generate a program to build the literate program.

```




```
«
«Uniquely Identifiable Boundary Mark»
«»

```
