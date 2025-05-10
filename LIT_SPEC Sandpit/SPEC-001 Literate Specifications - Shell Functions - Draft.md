# Literate Specification 

    **Created**: 2025-05-05

## An Introduction to Shell Functions

The *Literate Implementation Matrix* provides an overview
of whether the specification includes a reference implementation.

In this document, for literate specification to be considered 
to be implemented, it *MUST* provide the capability to use 
the function by executing a single code block. 

The literate specification should use a single line command 
to bootstrap capabilities from the documents, for example:

A generated shell script, which is available from the environment `PATH`;
if not saving the function to an existing `PATH` environment, the `PATH` 
should be updated via the literate specification.

Another way to achieve a capability is for the shell to load the function.
For instance, the `weather` function can be added as  `fish` function can 
be added as `$XDG_HOME_CONFIG/fish/weather.fish`.

### Status of Literate Documentation

The status of the literate document covers that functions within 
this document are implemented for the following:

- POSIX Shell (`sh`) 
- Bourne Again Shell (`bash`) 
- Z-Shell (`zsh`), and 
- Fish (`fish`)

                Literate Implementation Matrix
                -------------------------------

    **Not Implemented**   ✖   Heavy Multiplication X (U+2716)
    **Implemented**       ✔   Heavy Check Mark (U+2714)

            ╒══════════╤════╤══════╤═════╤══════╕
            │ function │ sh │ bash │ zsh │ fish │
            ├──────────┼────┼──────┼─────┼──────┤
            │ weather  │ ✖  │  ✖   │  ✖  │  ✖   │
            ╘══════════╧════╧══════╧═════╧══════╛



**How to update status**

The compatibility matrix *may* use the same macro declaration,
which will be treated as concatenation, when using 
literate capabilities that provide weaves literate 
code blocks. However, this document can be updated 
by including the function name, and a `y` or `n`
whether each shell is supported.

```text «implementation status»
function,sh,bash,zsh,fish
weather,n,n,n,y
```

**Commands to Display Implementation**

> **NOTICE** These will moved to the appendix, and this will be 
             used to provide the bootstrap command.
             The bootstrap command will extract the *bootstrap 
             literate codeblock*.
             

1. Extract the implementation status

```sh «extract implementation status»
THIS_FILE="add-weather-shell-func.LIT_SPEC.md"
cat "$THIS_FILE" | sed -nE '/^```[^$«]*«implementation status»[^$]*$/,/^```$/p' | sed '1d;$d' 
```

2. Render the crosses and ticks

```sh «render crosses and ticks»
sed -e '2,$s/n/✖ /g;2,$s/y/✔ /g';
```
3. Display Matrix 

> **Notice** The `tabulate` command comes from `python-tabulate`
             and is not part of this specification, and is expected
             to replaced in future versions.

```sh «csv to grid command»
tabulate -s ',' -f fancy_grid
```

This formats the *comma seperated values* into a fancy grid.

## Weather Shell Functions: A Literate Specification

I will be using literate specifications to present
a programming methodology taught by Donald Knuth; a system
where documentation and code are written in natural language.


The *web* of concepts in *CWEB* (a tool by Knuth
to *tangle* and *weave* writing), would generate
the code for the machine, and generate
typesetted documentation.

This *Literate Specification* will basically make a function that shows the weather in four different shell. This will
introduce some ideas. This will lead towards *Literate Configuration*, where we can use the new resources to be defined
in more interesting ways, such as adding tooling and things that will make work go faster.

https://github.com/chubin/wttr.in

**Synopsis**

Run `weather [:help]` from a supported shell.

The goal is to have a set of functions and capabilities, that can be composed and reused,
from this document itself.

The bootstrap capability is provided by [`OA-SPEC.LIT_SPEC#Bootstrap`: Literate Documents (*Literate Spec* ](oa:placeholder#not-done-yet).

Let's create the *show weather* capability for shells (like *zsh*, *sh*, *bash* and *fish*).

### Weather Functions: Reference Implementation

Here is a **reference implementation** for a `weather function`.

```fish «weather fish function»
function weather -a args; curl "wttr.in/$args" | most; end
```

**Tip** To Add or Extend `Literate Specs` is as simple as:

 1. Add a code block and provide a label for the codeblock:

```sh «weather bash function»
function weather(){ local args=${1:-":help"}; curl "wttr.in/$args" | less; }
weather
```

##################### TODO #########################

    ... Look at `weather :help` and
        get the `bash implementation` as per
        "wttr.in" ...

        ... create a literate codeblock with that ...


##################### TODO ZONE ################################

### Running the `Weather Functions`

**From an SHELL Command**

**From VIM or Neovim**

**From Capabilities from other Literate Specifications**


### ...Use macros to easily extend

    ... CHANGE THIS SO IT USES MACROS ...


*extensions*: Weather `weather function` Not yet implemented **
> **weather.sh**

>    [not implemented](oa:placeholder#not-done-yet)

> **weather.bash**

>    [not implemented](oa:placeholder#not-done-yet)

> **weather.zsh**

>    [not implemented](oa:placeholder#not-done-yet)


    ... build the functions that this function can
        be added to allow shell access to by default ...


##################### STILL TODO ZONE ###########################

        ...move to getting a png...

        ...refer to the literate specification...

            ...to continue the journey...

            ...as i guide the user to create an async
                state machine to display the weather on all the things ...

            ... then transliterate to go...

            ... create an intermediate language ...

            ... go to having advanced architecture ...

            ... spin up servers and high availability stuff ...



