# *DoDAF2*: An Architectural Framework Specification
**Tags**: #DoDAF2 #viewpoints #construction  #ArchitecturalEffort 
## Literate Specification: DoDAF2 Architectural Framework Components

## Summary and Overview

#### Scope
This specification provides a self-regenerating implementation. The specification defines the components, 
and the construction of a reference implementation to generate a resource description in terms of structure 
and construction.

#### Purpose
This document allows for specifications to be updated in a uniform manner that ensure 
the specification construction is internally consistent.


###  Architectural  Component Specification and Construction
> **Tags**: #abstract-compositional-topology #literate-spec #specification

This document will use `yaml` to be able to use the `head`, `tail` and `concat` primitives defined in the `Abstract Compositional Topology` construction, which uses the idea that using boundaries, to identify the (co)end, allow for a category theoretic framework, as it allows for the operations built using these ideas to be universal constructions. However, the use of `yaml` is only used for construction, and not as any formal requirement.


#### A `viewpoints` specification

The `«begin viewpoints specification»` token is provided as:

```yml «viewpoints begin specification»
viewpoints:
```

The resource schema will be represented as a `yaml` data structure as follows:

```
«begin viewpoints specification»
	«viewpoint specification»
```

where `«viewpoint «specification»»` is a concatenation of a single element from each of the following: `«begin viewpoint token»`, `«viewpoint title»` and `«viewpoint link»`.  
an empty (initial view schema`«views schema»` as specified as:

```lit-spec «views schema»
	«view»
```

The `«viewpoint item»`  is defined as a minimally if it contains the following structure:

```lit-spec «viewpoint specification item»
	«begin viewpoint token»
		«viewpoint title»
		«viewpoint link»	
```


The `«viewpoint keys»` are to merged in an iterative manner with each view point defining the `«viewpoint entry»` composed of an `«viewpoint specification key»`  from `«viewpoint keys»`, 
a `«viewpoint title»` from the `«viewpoint titles list»`, and a `«viewpoint link»`, from the `«viewpoint links list»`.

> [!Note]**Important**: The preservation of ordering also requires strict ordering between the individual `«viewpoints»` within this literate document, and the  `«architectural views and models descriptions»`,  `«architectural views item key»` and the  `«architectural views title»` regions delimited by a blank line. This constraint is to be removed in a later version. This is just due to the way the source data was when extracted (and corrected).

The `«viewpoint keys»`:

```yml «viewpoint keys»
  systems:
  standards:
  services:
  project:
  operational:
  data-and-information:
  capability:
  all-viewpoint:
```

The `«viewpoint titles list»` is provided as follows:

```yml «viewpoint titles list»
    title: "DODAF Viewpoints and Models - Systems Viewpoint"
    title: "DODAF Viewpoints and Models - Standards Viewpoint"
    title: "DODAF Viewpoints and Models - Services Viewpoint"
    title: "DODAF Viewpoints and Models - Project Viewpoint"
    title: "DODAF Viewpoints and Models - Operational Viewpoint"
    title: "DODAF Viewpoints and Models - Data and Information Viewpoint"
    title: "DODAF Viewpoints and Models - Capability Viewpoint"
    title: "DODAF Viewpoints and Models - All Viewpoint"
```

The `«viewpoint links list»`:

```yml «viewpoint links list»
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_systems/"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_standards/"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services/"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_project/"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_operational/"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_data/"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_capability/"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_all_view/"
```

So by taking;
> **TODO**: Find the bit where i've done this before

```sh «bootstrap entrypoint»
file_content=$(find . -name "LIT_SPEC Architectural Framework.md" -exec cat {} +)
echo "$file_content" | sed -n '/^```sh «execution block»$/,/^```$/{/^```/d;p}' | sh -
```

```sh «execution block»
file_content=$(find . -name "LIT_SPEC Architectural Framework.md" -exec cat {} +)
# Improved codeblock extraction function
get_literate_codeblock() {
    local token_name="$1"
    sed -n "
        /^\`\`\`[^«]*«$token_name»\$/,/^\`\`\`\$/ {
            /^\`\`\`/d
            p
        }
    " <<< "$file_content"
}

adjust_title(){
 sed 's/DODAF Viewpoints and Models - //g'
}

assemble_viewpoints(){
# Extract the code blocks
    keys_block=$(get_literate_codeblock "viewpoint keys")
    titles_block=$(get_literate_codeblock "viewpoint titles list" | adjust_title)
    links_block=$(get_literate_codeblock "viewpoint links list")

#echo "$keys"
    IFS=$'\n' read -d '' -ra keys_array <<< "$keys_block"
    IFS=$'\n' read -d '' -ra titles_array <<< "$titles_block"
    IFS=$'\n' read -d '' -ra links_array <<< "$links_block"
    n=${#keys_array[@]}
    echo $(get_literate_codeblock "viewpoints begin specification")
    for ((i=0; i<n; i++)); do
       echo "${keys_array[$i]}"
       echo "${titles_array[$i]}"
       echo "${links_array[$i]}"
    done
}

assembled_viewpoints=$(assemble_viewpoints)
# echo "$assembled_viewpoints"
```

For the purposes of reducing the length of the the model viewpoint titles, the 
prepended `DODAF Viewpoints and Models - ` has been truncated.

```yml «output from assembled viewpoints before adjusting title»
viewpoints:
  systems:
    title: "DODAF Viewpoints and Models - Systems Viewpoint"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_systems/"
  standards:
    title: "DODAF Viewpoints and Models - Standards Viewpoint"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_standards/"
  services:
    title: "DODAF Viewpoints and Models - Services Viewpoint"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services/"
  project:
    title: "DODAF Viewpoints and Models - Project Viewpoint"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_project/"
  operational:
    title: "DODAF Viewpoints and Models - Operational Viewpoint"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_operational/"
  data-and-information:
    title: "DODAF Viewpoints and Models - Data and Information Viewpoint"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_data/"
  capability:
    title: "DODAF Viewpoints and Models - Capability Viewpoint"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_capability/"
  all-viewpoint:
    title: "DODAF Viewpoints and Models - All Viewpoint"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_all_view/"
```

#### A `views` Component Specification

This is used to provide a `«viewpoint with views specification item»`:

```lit-spec «viewpoint with views specification»
«viewpoint specification item»
«begin views specification»
«viewpoint views specification»
```

The `«begin views specification»` token is defined as:

```yml «begin views specification»
		views:
```

%%

> **Under Consideration** Change the 'services«Service View ID» to `svc«Service View ID»` or well we can change it for the tags.
> These do resolve naturally to the the resource `url` path scheme. #rfc3986 #uri 

%%


```yml «view keys»
sv1
sv2
sv3
sv4
sv5a
sv5b
sv6
sv7
sv8
sv9
sv10a
sv10b
sv10c

stdv1
stdv2

services1
services2
services3a
services3b
services4
services5
services6
services7
services8
services9
services10a
services10b
services10c

pv1
pv2
pv3

ov1
ov2
ov3
ov4
ov5ab
ov5ab
ov6a
ov6b
ov6c

div1
div2
div3

cv1
cv3
cv2
cv4
cv5
cv6
cv7

av1
av2
```

this will like in `oa/architecture/reference/dodaf2/viewpoint id»/«view id»`

```yml «view links»
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv1/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv2/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv3/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv4/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv5a/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv5b/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv6/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv7/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv8/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv9/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv10a/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv10b/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_sv10c/

link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_stdv1/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_stdv2/

link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services1/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services2/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services3a/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services3b/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services4/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services5/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services6/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services7/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services8/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services9/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services10a/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services10b/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_services10c/

link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_pv1/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_pv2/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_pv3/

link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_ov1/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_ov2/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_ov3/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_ov4/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_ov5ab/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_ov5ab/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_ov6a/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_ov6b/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_ov6c/

link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_div1/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_div2/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_div3/

link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_cv1/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_cv3/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_cv2/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_cv4/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_cv5/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_cv6/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_cv7/

link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_av1/
link: https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_av2/
```

```yml «architectural views titles»
SV-1: Systems Interface Description
SV-2: Systems Resource Flow Description
SV-3: Systems-Systems Matrix
SV-4: Systems Functionality Description
SV-5a: Operational Activity to Systems Function Traceability Matrix
SV-5b: Operational Activity to Systems Traceability Matrix
SV-6: Systems Resource Flow Matrix
SV-7: Systems Measures Matrix
SV-8: Systems Evolution Description
SV-9: Systems Technology and Skills Forecast
SV-10a: Systems Rules Model
SV-10b: Systems State Transition Description
SV-10c: Systems Event-Trace Description

StdV-1: Standards Profile
StdV-2: Standards Forecast

SvcV-1: Services Interface Description
SvcV-2: Services Resource Flow Description
SvcV-3a: Systems-Services Matrix
SvcV-3b: Services-Services Matrix
SvcV-4: Services Functionality Description
SvcV-5: Operational Activity to Services Traceability Matrix
SvcV-6: Services Resource Flow Matrix
SvcV-7: Services Measures Matrix
SvcV-8: Services Evolution Description
SvcV-9: Services Technology and Skills Forecast
SvcV-10a: Services Rules Model
SvcV-10b: Services State Transition Description
SvcV-10c: Services Event-Trace Description

PV-1: Project Portfolio Relationships
PV-2: Project Timelines
PV-3: Project to Capability Mapping

OV-1: High Level Operational Concept Graphic
OV-2: Operational Resource Flow Description
OV-3: Operational Resource Flow Matrix
OV-4: Organizational Relationships Chart
OV-5a: Operational Activity Decomposition Tree
OV-5b: Operational Activity
OV-6a: Operational Rules Model
OV-6b: State Transition Description
OV-6c: Event-Trace Description

DIV-1: Conceptual Data Model
DIV-2: Logical Data Model
DIV-3: Physical Data Model

CV-1: Vision
CV-2: Capability Taxonomy
CV-3: Capability Phasing
CV-4: Capability Dependencies
CV-5: Capability to Organizational Development Mapping
CV-6: Capability to Operational Activities Mapping
CV-7: Capability to Services Mapping

AV-1: Architecture Overview and Summary
AV-2: Integrated Dictionary
```

```sh «verification block»

    view_keys_block=$(get_literate_codeblock "view keys")
    view_links_block=$(get_literate_codeblock "view links")
    view_titles_block=$(get_literate_codeblock "architectural views titles")
    echo "$view_keys_block" | grep -n "^$" | xargs echo | tr ':' ' '
    echo "$view_links_block" | grep -n "^$" | xargs echo | tr ':' ' '
    echo "$view_titles_block" | grep -n "^$" | xargs echo | tr ':' ' '
    # this returns 
    # 14  17  31  35  45  49  57 
    # 14  17  31  35  45  49  57 
    # 14  17  31  35  45  49  57 
```

```sh «execution block»
assemble_views() {
    # Get the required code blocks
    view_keys_block=$(get_literate_codeblock "view keys")
    view_links_block=$(get_literate_codeblock "view links")
    view_titles_block=$(get_literate_codeblock "architectural views titles")
   
    # Define viewpoint groups in order
    viewpoints=("systems" "standards" "services" "project" "operational" "data-and-information" "capability" "all-viewpoint")
       
    # Initialize variables
    group_index=0
    current_viewpoint="${viewpoints[0]}" 
    # Convert to arrays
    #IFS=$'\n' read -d '' -ra keys_array <<< "$view_keys_block"
    #IFS=$'\n' read -d '' -ra links_array <<< "$view_links_block"
    #IFS=$'\n' read -d '' -ra titles_array <<< "$view_titles_block"

    readarray -t keys_array <<< "$view_keys_block"
    readarray -t links_array <<< "$view_links_block"
    readarray -t titles_array <<< "$view_titles_block"
    # Group views by viewpoint
    echo "views:"
    for i in "${!keys_array[@]}"; do
        # If we hit a blank line, increment group index and skip
        #if [[ -z "${keys_array[i]}" ]]; then
        if [ "${keys_array[i]}" = "" ]; then
            group_index=$((group_index + 1))
            current_viewpoint="${viewpoints[group_index]}"
            continue
        fi
        
        # Extract components
        view_key="${keys_array[i]}"
        view_link="${links_array[i]#link: }"
        view_title="${titles_array[i]}"
        
        # Parse title components
        view_id="${view_title%%:*}"
        view_name="${view_title#*: }"
        
        # Output YAML structure
        echo "  $view_key:"
        echo "    viewpoint: $current_viewpoint"
        echo "    id: \"$view_id\""
        echo "    name: \"$view_title\""
        echo "    label: \"$view_name\""
        echo "    link: \"$view_link\""
    done
}
```

```sh «execution block»
# Call the function
assembled_views=$(assemble_views)
echo "$assembled_views"
```


```yml «dodaf meta models viewpoint»
meta models:
  ontology:
    title: "DODAF Formal Ontology"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_ontology1/"
  conceptual:
    title: "DODAF Viewpoints and Models - Conceptual Meta-Model"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_conceptual/"
  logical: 
    title: "DODAF Viewpoints and Models - Logical Meta-Model"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_logical/"
  pes:
    title: "Physical Exchange Specification"
    link: "https://dodcio.defense.gov/Library/DoD-Architecture-Framework/dodaf20_pes/"
```

```sh «execution block»
assemble_meta_models() {
    meta_block=$(get_literate_codeblock "dodaf meta models viewpoint" | adjust_title)
    echo "$meta_block"
}

assembled_meta=$(assemble_meta_models)
# echo "$assembled_meta"
```

## Output Formats

### Store as yaml files

```sh «execution block»
OUTPUT_DIR="/tmp/architecture-model"
mkdir -p "$OUTPUT_DIR"
```

```sh «execution block»
echo "$assembled_viewpoints" > "$OUTPUT_DIR/viewpoints.yml"
echo "$assembled_views" > "$OUTPUT_DIR/views.yml"
echo "$assembled_meta" > "$OUTPUT_DIR/meta-models.yml"
cat "$OUTPUT_DIR/views.yml" "$OUTPUT_DIR/viewpoints.yml" "$OUTPUT_DIR/meta-models.yml" > "$OUTPUT_DIR/architecture.yml"
```


```sh «execution block»
echo "$assembled_viewpoints"
echo "$assembled_views"
echo "$assembled_meta"
```

# Convert to CSV Tools
```sh
cat > "$OUTPUT_DIR/generate-csv.sh" <<<'EOF'
#!/bin/sh
create_view_csv(){
    echo "viewpoint,view_id,name,key,title,link"
    yq '.views | to_entries | map({
        view: .value.id,  # Use DoDAF ID as primary identifier
        viewpoint: .value.viewpoint,
        title: .value.name,
        label: .value.label,
        link: .value.link,
        key: .key  # Keep original key for reference
    }) | .[] | [.viewpoint, .view, .label, .key, .title, .link] | @csv' views.yml -r
}
```

```sh «execution block»
cat > "$OUTPUT_DIR/generate-csv.sh" <<'EOF'
DEFAULT_OUTPUT_DIR="."
# CSV Generator for DoDAF Architectural Framework
# Auto-generated from literate specification

# Exit on error and show commands
set -ex

# Create CSV for views
create_view_csv() {
    echo "viewpoint,view_id,key,title,label,link"
    yq '
        .views | to_entries | map([
            .value.viewpoint, 
            .value.id, 
            .key, 
            .value.name, 
            .value.label, 
            .value.link
        ]) | .[] | @csv
    ' -r "$1/views.yml"
}

create_viewpoint_csv() {
    echo "id,title,link"
    yq '
        .viewpoints | to_entries | map([
            .key, 
            .value.title, 
            .value.link
        ]) | .[] | @csv
    ' -r "$1/viewpoints.yml"
}

# Create CSV for meta-models
create_meta_model_csv() {
    echo "id,title,link"
    yq '
        ."meta models" | to_entries | map([
            .key, 
            .value.title, 
            .value.link
        ]) | .[] | @csv
    ' -r "$1/meta-models.yml"
}
# Main execution
main() {
    OUTPUT_DIR="${1:-$DEFAULT_OUTPUT_DIR}"
    if [[ -d "$OUTPUT_DIR" ]]; then 
       mkdir -p "$OUTPUT_DIR/csv"
    fi
    create_view_csv "$OUTPUT_DIR" > "$OUTPUT_DIR/csv/views.csv"
    create_viewpoint_csv "$OUTPUT_DIR" > "$OUTPUT_DIR/csv/viewpoints.csv"
    create_meta_model_csv "$OUTPUT_DIR" > "$OUTPUT_DIR/csv/meta-models.csv"
    echo "CSV files generated in $OUTPUT_DIR/csv/"
}
main "$@"
EOF
chmod +x "$OUTPUT_DIR/generate-csv.sh"
```

# Convert to JSON Tools
```sh «execution block»
cat > "$OUTPUT_DIR/generate-json.sh" <<'EOF'
DEFAULT_OUTPUT_DIR="."
# JSON Conversion Tool for Architectural Framework
# Auto-generated from literate specification

# Main execution
main() {
    OUTPUT_DIR="${1:-$DEFAULT_OUTPUT_DIR}"
    if [[ -d "$OUTPUT_DIR" ]]; then 
       mkdir -p "$OUTPUT_DIR/json"
    fi
    yq '{"meta models": ."meta models", "viewpoints": ."viewpoints", "views": ."views"}' "$OUTPUT_DIR/architecture.yml" > "$OUTPUT_DIR/json/architecture.json"
    echo "JSON files generated in $OUTPUT_DIR/json/"
}
main "$@"
EOF
chmod +x "$OUTPUT_DIR/generate-json.sh"

```

## Verification

> **Tags**: #work-in-progress

**Test that `meta-models.yml`, `architecture.yml`, `views.yml` and `viewpoints.yml` are valid**

**Test that tools generate `csv` and `json` for each**



## Appendix: Literate Document Enrichment

### Embedded Neovim Literate Toolchain

Bootstrap the Neovim Literate Tools by pressing `<Shift>` and `V` over the codeblock below,
to visually select the `init` function and `init()` method and type `:lua`.

This snippet will register the user command 'LitExec' in neovim for this document and triggered 
with `\` followed by `<Tab>`.

```lua «Literate Tools for Neovim»
function init()
    function execute()
        cmd = 'w !tail -n1 | sh -'
        print "Registered execute command."
        return function() vim.cmd(cmd) end
    end
    vim.api.nvim_create_user_command('LitExec', execute(),{})
    vim.keymap.set('n','\\<Tab>',':LitExec<CR>')
end
init()
```

### How to execute this document

By running `tail -n 1 | sh -` on this document, the 
document will generate a reference implementation of this specification.

It will call the following command located in [Literate Specifications](#literate-specifications).

    fd "LIT_SPEC Architectural Framework.md" | xargs -I{} cat "{}" | sed -n '/^```sh «bootstrap entrypoint»$/,/^```$/{/^```/d;p}' | sh -
