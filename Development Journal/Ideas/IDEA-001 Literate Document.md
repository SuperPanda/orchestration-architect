# IDEA-001 Literate Document
    
    **Resource Id**: IDEA-001
    **Created**: 2025-04-11
    **Description**: A Literal Approach for Literate Writing
    **Status**: Draft
    **Tags**: #Literate #SelfAssembly #Architecture #LitSpec
    **Related Resources**: 

## Rationale 

Literate Writing as conceived by Knuth is a style of writing that can self-actualise. In that the writing is done in a way that it allows writing in a way that naturally coheres with ones train of thought. It also ensures that as the writing, is the implementation, that careful and considered thought is given to the design to allow the composition of fragments.

A benefit is that variants can be made by describing how things could be different. A prototype has shown that a project can be converted into a literate document, such that it can be annotated, and then use of an alternative dependency was considered, and by simply adding how the in part would fit into the applications structure, the document was able to generate variants of the implementation.

## Design

In my prototyping I have found that by writing each segment that can be run in isolation is a good level of abstraction.

The idea is that by following a common structure such that regexes can apply pattern matching on the relevant structures.


**Architectural Design Record**: Ensure the system is bootstrappable such that the system self-assembles (achieve local isle of stability in a sea of chaos).

**Architectural Design Record**: Ensure that all output and configuration can be intuitive and readable without any tools (resilience against entropy).

**Architectural Design Record**: Ensure naturally coherent structures (embrace compositionality to achieve functionality through combinatorial interactions from linearly developed resources)

In order to achieve universal propertie is, each document should support the following concepts:

**A document can be identified uniquely** (category theory axiom: all objects must have an identity morphism).

> [!tip] Heuristic for Designing Models
> Ensure that each entity can begin with an `a` or `an` as this shows that is should generally hold, where `the` refers to an instance or element, which highlights that the wrong level of abstraction is in use (or incoherent).


**A modificaton to a document can be modified such that the identity is preserved** (composition with identity morphism maintains commutativity).

**A document has an default initialised state** (universal construction): brings it into existence that works such that it is able to compose with other operations within the hom-set.


### Worked Example 

Consider that a file `IDEA-001` is supplied, if a `IDEA-001` is generated in a different system.

It would be unable to resolve the IDEA-001 File name naturally.

However, by having the "NOTE-001 Date Title.md", it can take "NOTE-001 DATE-2 Title From A.md" and "NOTE-001 DATE-1 Title From B.md", then an upsert can fix naturally based on some pre-order. 
        
So a lexiographical sort will be able to select the earlier date, otherwise it will use the title.

**Idea**: Could it be possible to make a timestamp generate deterministic Unique IDs by mapping tz bits to characters?

## Document Structures

A document class should use a consistent structure.

Header hierarchary should reflect the `less than or equal to` preorder relationships.

Examples of identifying hierarchy and heterarchical regions:

 - Identify all the '^[#]{1}[#]{1}' would be the document 

 - Each `'^[#]{2}[^#]{1}'` should result in all the level 2 headings.

  - By using the markers to get line numbers, we can use the operations `tail` and `head`

  - To get the region before the first matching '[#]{2}' we can just get 'head -n +line_number_of_first_match`

**Idea**: ctags naturally generates these regex patterns

Using `cut -f<FIELDS>` and adjusting the fields it is possible to get a combination of properties (when included with `grep` like including the found tag types, and grepping `<TAG TYPE>$` would allow `s$` to return a list of sections.

That is, headers define a block, where containment is defined to be `less than or equal to`

  - Blocks defined as siblings should have a heterarchical relation.











