## Render D2 Diagrams

### Synopsis

**Install `mdbook-d2` with `cargo install mdbook-d2 --locked`**

**Append the following to `book.toml`**

    [preprocessor.d2]
    layout = "elk"
    inline = true


### Requirements

The use of `d2` has been identified as an appropriate modelling 
tool due to the ability to easily represent the applied category theoretic constructs
used repeated through systems and higher order components.

Due to the field being relatively new, a simple and composable language
`d2` has been chosen due to the compositional capabilities 
emerging from the language design.

The ease that `mdbook` generates content while working within `neovim`
such that the content allows for easier viewing in the web browser, 
has been quite useful.

Also, a lot of diagrams already exist written in `d2`, and storing the rendered 
`SVG` interferes with `rg` results (requiring extra steps to avoid). 

### Analysis

A core architectural decision made to have the whole system bootstrappable and understandable
using literate writing. Though ideally, I should avoid third party pages, I need to 
move forward. It seems easy enough to swap out later and  will not stop the system 
from working if there is a problem. The 
literate programming system, will eventually swap out anyway the component anyway as it just 
acts as the shortest path to getting the job done without causing any long term commitments.
Ideally, in the future it would be wild to see `d2` compiled to wasm, and allow the system to generate 
a local system, where you could modify the system using the diagrams.

But distractions aside, the rust crate `mdbook-d2` which is a "D2 preprocessor for mdbook" will suffice. The 
dependencies for it are `mdbook` and `d2`.

Source: [The `mdbook-d2` crates.io webpage](https://crates.io/crates/mdbook-d2)

### Implementation

```sh «how to install the mdbook-d2 preprocessor»
# requires `mdbook`, cargo installed binaries to be in `$PATHS`, and `d2` to be installed.
cargo install mdbook-d2 --locked
```

### Configuration

The documentation provides configuration instructions as:

    
    [preprocessor.d2]

    # path to d2 binary.
    # optional. default is "d2" (ie. on the path).
    path = "d2"

    # layout engine for diagrams. See https://github.com/terrastruct/d2#plugins.
    # optional. default is "dagre".
    layout = "dagre"

    # whether to use inline svg when rendering.
    # if 'false', separate files will be generated in src/<output-dir> and referenced.
    # optional. default is 'true'
    inline = true

    # output directory relative to `src/` for generated diagrams.
    # This is ignored if 'inline' is 'true'.
    # optional. default is "d2".
    output-dir = "d2"

**Configuration**

For `path` the current use case, we will assume `d2` is in the `PATHS` environment 
variable. This value need not be in our configuration.

The prototyping found `elk` more aesthetically pleasing for models.

The diagrams ideally are quite small, as the design of the system is to 
create components compositional. The animation and story board capabilities 
are not required, nor should be handled by `d2`, as the diagrams should naturally
reflect the state of the system. Also, the `oa-monitor` tool identifies a lot 
of file system activity, and due to the system needing to be understandable, 
reducing unnecessary complexity and files is ideal. As this allow more portability 
later on. Since `d2` already exists, `mdbook` is not responsible for generating 
the diagrams; therefore, `output-dir` does not need to be set, and inline 
needs to be set to true.

The provided `book.toml` configuration should be added:

```toml «append to book.toml»
[preprocessor.d2]
path = "d2"
layout = "elk"
inline = true
```

### Verification 

**The following should now render as a diagram:**

```d2
direction: right
install -> configure -> run
```

---
