# Use Commands to Populate Documents

## Synopsis

**Install `mdbook-cmdrun` with `cargo install mdbook-cmdrun**

## Requirements 

The systems need to be self-documenting due to 
the cognitive overload, when trying to reason with 
the system. As the design patterns are based on building 
higher order systems in a manner that when 
working on a system, the relative context is hard 
to manage in the mind. 

```d2
direction: right
X: {
    a: {a1 -> a2; a1 -> a3}
    b: {b2 -> b3; b1 -> b3}
    c: {c1 -> c3; c1 -> c2}

    a.* -> a.*
    b.* -> b.*
    c.* -> c.*

    * -> *
}
```

This architecture is quite simple to extend, and understand 
but to track the components, it can be quite of a cognitive burden. 

The development process should naturally capture the rationale and 
purpose for each component in real time. Usually, it is to provide a subsystem 
with some functionality, like automatically ensuring certain base properties 
to coerce the components to meet some axiomatic requirement (from 
category theory). 

And the reason for the higher order component,
the system will automatically 
build themselves, means that we need to look at the 
components for a given context.

```d2
direction: right
Level 1 - Subsystem A: { a1 -> a2; a1 -> a3 }
Level 1 - Subsystem B: { b1 -> b2; b1 -> b3; b2 -> b3; }
Level 1 - Subsystem C: { c1 -> c2; c1 -> c3 }

Level 1 - * -> Level 2: is-component-for

Level 2: { A -> B; B -> C; A -> C; }


```

## Analysis

The system is built as functors between systems,
therefore we need a functor to provide a representation.

Thus, the preprocessor `mdbook-cmdrun` can be used to weave 
the different components and transformations, as needed.

Since everything is driven by specifications and configurations
it will be ideal just to read the specs and configurations; 
or check the generated components.

How do I get the list of projects? Look at where the projects are defined.

The configuration system provides the `$OA_PROJECTS_PATH` environment variable, 
and provides a `oa-projects` command in the shell. 

Here is roughly how its structured (the actual structure will be provided 
during verification), 

    File: $OA_PROJECTS_PATH/PROJECT_OVERVIEW.md
    # PROJECT SUMMARY

    ## Active Projects
    - [ARCHITECTURE](./kanbans/ARCHITECTURE)

    ## Inactive Projects

    - [CONFIGURATION](./kanbans/CONFIGURATION)
    - [LITERATE SPECIFICATIONS](./kanbans/LIT_SPEC)

And here's a rough sketch

```d2
direction: right;
PROJECTS SUMMARY: {
    ACTIVE: {
        ARCHITECTURE;
    }
    INACTIVE:  {
        CONFIGURATION;
        LITERATE SPECIFICATIONS;
    }
}

PROJECTS SUMMARY.*.* -> PROJECT: is a

```

The idea is that projects are added as needed, and the 
resources used for a project can connect as needed, based on things 
that work, when a resource moves structurally, but is logically connected,
the design is that just because I moved or renamed things, does not 
mean that its functionally different. A single source of truth commutes.

For further information regarding this implementation of projects,
it seems stupid, and it is a little, but it has some interesting properties,
and it was the simplest solution.

See Minsky (1987; 2008) about K-Lines, and lookup the Yoneda lemma, 
where objects are fully defined by a set of homomorphisms.

So, to see all the projects, I need to extract the components using the specified 
components, like `$OA_PROJECTS_PATH`. This creates a sort of natural cascade effect.

An added *Project* already is fully defined, allowing simple reasoning, if the 
information easily viewable.

Consider, that if I want to know what tasks to work on, then the active projects, defines 
a topological filter over the kanbans, so I can see the active tasks. When context switching, the tasks are out of view 
but there structure is preserved.

**Source** [mdBook Documentation](<https://rust-lang.github.io/mdBook>) could be used as **Resource** later.

Anyway, a lot of work to do, so look at what can find. 

I could build a preprocessor to do what I need 
according to [mdBook developer docs (preprocessors)](<https://rust-lang.github.io/mdBook/for_developers/preprocessors.html>).
I will take note that I later setup a latex to mathjax processor.

The [`mdbook-cmdrun` crate](<https://docs.rs/mdbook-cmdrun/latest/mdbook_cmdrun/>) allows 
commands to be used in the preprocessor, which aligns with how the literate writing tooling 
that have been investigating works. Since transclusions and running commands 
are isomorphic to how the systems, the natural transformations nicely maps
to the existing architecture.

Let us set up the `cmdrun` template.

> **WARNING** The `cmdrun` exposes very sensitive information if unchecked. 
> This is both a blessing and a curse. This will ensure that each part of the process 
> is properly isolated. The bad news is, that it is very dangerous.
> For example, if you have SECRETS in the environment variables, it will be accessible 
> via the cmdrun command. The benefit is that you can check to see that the environment 
> variables are clean.

## Implementation 

```sh
cargo install mdbook-cmdrun
```

## Configuration 

Put this in the `book.toml`.

```toml
[preprocessor.cmdrun]
```

**Note** It may be required to 
Ensure `mdbook-cmdrun` run can 

### 2.6 Verification 

This should render:

```
<!-- cmdrun seq 1 10 -->
```
