# User Guide Resources
## Operations: Configure Services for Productivity

The rapid development and deployment of productivity utilities
is essential in managing the cognitive overhead with context switching 
and refocus after returning to use the systems.

These utilities aim to aid in organizing desktop environment to facilitate 
context switching, as we work towards a structured 

### Hyprland Workspace Utilities

#### Add Workspace Indicators to `waybar`

```fish «command to set '$XDG_CONFIG_HOME' to '$HOME/.config'»
# Check if XDG_CONFIG_HOME is not set
if not set -q XDG_CONFIG_HOME
   # Default to $HOME/.config if XDG_CONFIG_HOME is not set
   set -Ux XDG_CONFIG_HOME $HOME/.config
end
```

**File `$XDG_CONFIG_HOME/waybar/style`**:

```css «add workspace indicators in waybar»
#waybar {
  opacity: 1;
  background: transparent;
  border-bottom: white double 1px;
  min-height: 100px;
}

#clock {
  background-color: black;
  border: white solid 1px;
  border-radius: 4px;
  color: lime;
  font-size: x-large;
  font-family: "SourceCodePro", "sans-serif";
  font-weight: bolder;
  margin: 4px 4px 4px 4px;
  padding: 2px;
}

#cpu,
#cpu a,
#memory,
#memory a,
#network,
#network a,
#tray,
#tray a {
  background-color: rgba(255, 255, 255, 0);
  color: lime;
  padding: 4px;
  border-radius: 4px;
  min-width: 10px;
  border: white solid 1px;
  margin: 4px 4px 4px 4px;
}


#cpu {
  background-color: black;
}


#workspaces button {
  min-width: 100px;
  color: white;
  background: black;
  border-color: white;
  margin: 0px 4px 4px 4px;
}

#workspaces button:hover {
  background-color: white;
  color: black;
  border-color: cyan;
}

#workspaces button.active {
  border-color: cyan;
}

```


**Workspace Management Functions**

These functions enhance workspace management in Hyprland by allowing dynamic naming:

1. **`get-current-workspace-id`**  
   Retrieves the numeric ID of the currently focused workspace.

2. **`set-workspace-name`**  
   Assigns names to workspaces using the format `ID: LABEL`. Supports:
   - Renaming current workspace
   - Resetting to default ID
   - Targeting specific workspaces

**Usage Examples**:

```fish «User Guide to Rename Workspaces»
# Get current workspace ID (e.g. output: 9)
get-current-workspace-id

# Rename current workspace to "9: ARCHITECTURE"
set-workspace-name "ARCHITECTURE"

# Rename workspace 10 to "10: PROJECT"
set-workspace-name "PROJECT" 10

# Reset current workspace name (e.g. to "9")
set-workspace-name ""

# Reset workspace 10 to "10"
set-workspace-name "" 10
```

**Features**:
- Auto-detects current workspace when ID isn't specified
- Maintains Hyprland's workspace ID prefix for visual consistency


```sh «rename hyprland workspaces»
#!/usr/bin/fish

## Function: get-current-workspace-id
# Description: Retrieves the ID of the currently active workspace
function get-current-workspace-id -d "Get current workspace ID"
    # Extract workspace ID using hyprctl with regex parsing:
    # 1. `hyprctl activeworkspace` outputs workspace details
    # 2. `grep -oP` matches 'workspace ID <digits>' pattern
    # 3. `cut` extracts the 3rd field (the numeric ID)
    hyprctl activeworkspace | grep -oP "workspace ID \d{1,2}" | cut -f3 -d\ 
end

## Function: set-workspace-name
# Description: Assigns a name to a specified workspace or the current workspace
# Usage: 
#   set-workspace-name [NAME] [WORKSPACE_ID]
#   - NAME: Label text (optional, omit to reset name)
#   - WORKSPACE_ID: Target workspace (optional, uses current if omitted)
function set-workspace-name -d "Set a name for a Hyprland workspace" -a name id
    # Handle missing workspace ID
    if test -z "$id"
        set id (get-current-workspace-id)
    end

    # Reset to default (numeric only) if no name provided
    if test -z "$name"
        hyprctl dispatch renameworkspace $id "$id"
    # Apply custom name in "ID: LABEL" format
    else
        hyprctl dispatch renameworkspace $id "$id: $name"
    end
end
```

### Shell Configurations 


#### Setup Configuration


```fish «oa-load-environment.fish»
#!/bin/fish
set -l source "$(pwd)/shell-configurations/orchestration-architect.fish"
set -l target "$HOME/.config/fish/conf.d/orchestration-architect.fish"
echo "Copying '$source' to '$target'..."
cp "$source" "$target"
echo "Copied '$source' to '$target'."
```


```fish «fish utilities configuration»
#!/bin/fish
set OA_WORKSPACE_PATH "$HOME/repos/orchestration-architect" 
set OA_DOCS_PATH "$OA_WORKSPACE_PATH/documentation"
set OA_JOURNAL_PATH "$OA_DOCS_PATH/Development Journal"
set OA_TOOLS_PATH "$OA_WORKSPACE_PATH/tools"
set OA_NOTES_PATH "$OA_JOURNAL_PATH/Notes"
set OA_SANDBOX_PATH "$OA_WORKSPACE_PATH/sandbox"
set OA_KANBANS_PATH "$OA_JOURNAL_PATH/Projects/Kanban"
set OA_PROJECTS_PATH "$OA_JOURNAL_PATH/Projects/PROJECT_OVERVIEW.md"
function oa-find-kanban -a query; fd "$query" "$OA_KANBANS_PATH"; end
function oa-find-note -a query; fd "$query" "$OA_NOTES_PATH"; end
function oa-kanban; cd "$OA_KANBANS_PATH"; end
function oa-notes; cd "$OA_NOTES_PATH"; end
function oa-sandbox; cd "$OA_SANDBOX_PATH"; end
function oa-tools; cd "$OA_TOOLS_PATH"; end
function oa-list-projects; bat "$OA_PROJECTS_PATH"; end
function oa-projects; nvim "$OA_PROJECTS_PATH"; end
function oa-display-projects; echo "$OA_PROJECTS_PATH" | entr -ncc bat "$OA_PROJECTS_PATH"; end
```

## Repository

### Bare Repository

> **Note**: An authorative repository is not pushed too, but 
>           the system pulls from the provision systems. 

**Authorative Repository**: `ssh://oa001-dev/srv/git/orchestration-architect.git`

**System Repository**: `/srv/git/orchestration-architect.git`

**User Repository**: `$HOME/repos/orchestration-architect.git` (the bare repo will be moved to `$XDG_USER_DATA`)

### Git Branches: Repo `orchestration-architect.git`
 
**Introduction**

The repositories are structured in some category theoretic way to 
support some concepts related to compositionality, by making the 
branches less coupled, whilst being maintaining cohesion.

This is also to support the self-bootstrap and self-assembly protocols.

**Branch Naming Scheme**

A branch name is set to be `«version»-«content-type branch»`.

> **Tip**: Find more unreleased notes at `rg worktree "$OA_SANDBOX_PATH" --files-with-matches`.

### Work Trees 

> **Task**: Finish this by setting `workspace.config` according to *XDG Desktop Specifications*
>           Add the `setup-worktrees` in the `$HOME/.local/bin/` or `/usr/bin/local` (unless packaged).
>           Auto render `../sandbox/CONFIG Sandpit/workspace-configuration/oa-worktrees.d2` in document.

```
> rg "workspace" "../sandbox/"
```

**File `workspace-configuration/workspace.config`**:

```config «workspace config»
develop 0.8.0-dev
assets  0.8.0-assets
documentation  0.8.0-documents
initial  0.8.0-initial
pristine  0.8.0-pristine
sandbox 0.8.0-sandbox
seed  0.8.0-seed
tests  0.8.0-tests
tools  0.8.0-tools
splash pre-release_splash
```

```sh «Worktree-Workspace Configurator»
#!/bin/sh

LOCAL_WORKSPACE="$HOME/repos/orchestration-architect"
USER_REPO="$HOME/repos/orchestration-architect.git"

while IFS=' ' read -r branch ref; do
  cd "$USER_REPO" || exit
  git worktree add "$LOCAL_WORKSPACE/$branch" "$ref"
done
```

```nvim «Apply Workspace-Worktree Configuration»
vim.api.nvim_exec2({':echo hi'},{})
```





### Troubleshooting Remotes and Worktrees
    
> **Note**: Running `git branch -r -l -a`  gives you a list of remotes and there tracking status

The `+` branches are being tracked (I assume). I know the other two are using a different  bare repository.
The `*` is the current branch.

    $ git branch -r -l '<remote>/<pattern>'

```git «branch -r -l -a»
+ 0.8.0-assets
  0.8.0-dev
* 0.8.0-documents
+ 0.8.0-initial
+ 0.8.0-pristine
  0.8.0-sandbox
+ 0.8.0-seed
+ 0.8.0-tests
+ 0.8.0-tools
+ pre-release_splash
  remotes/github/0.8.0-assets
  remotes/github/0.8.0-dev
  remotes/github/0.8.0-documents
  remotes/github/0.8.0-initial
  remotes/github/0.8.0-pristine
  remotes/github/0.8.0-seed
  remotes/github/0.8.0-tests
  remotes/github/0.8.0-tools
  remotes/github/pre-release_splash
```

    $ git for-each-ref 'refs/remotes/<remote>/<pattern>'    

```git «for-each-ref 'refs/remotes/github/0.8.0-*'»
e8d57df110ab1f303f8ab0d41a2ec558d29979a4 commit refs/remotes/github/0.8.0-assets
3c707d1fcd49bc30c3830678fd995eebe4aec5c0 commit refs/remotes/github/0.8.0-dev
ae743c56445f440d17922951cc6d69aa29da0d6a commit refs/remotes/github/0.8.0-documents
54abbbb6981ed0d731881fa3dd7a58a1c1b88203 commit refs/remotes/github/0.8.0-initial
5fccae8a21b5967e9745ee4525ce8800a8751b99 commit refs/remotes/github/0.8.0-pristine
db9006842883077a3beca0cf4b6b537ccb449b00 commit refs/remotes/github/0.8.0-seed
9a4920996f801d6fcc79af62ca0a6884d21b0a74 commit refs/remotes/github/0.8.0-tests
5c384d972aa1944f844b47e06e1f5f70c5c152b1 commit refs/remotes/github/0.8.0-tools
```

## Documentation Capability

### Capability: Live Rendering of D2 Diagrams 

[D2 Diagrams Rendering](./../../sandbox/ARCHITECTURE Sandpit/prototypes/architecture-book-prototype/src/example/01-oa-docs-01-mdbook.md#required-capability-render-d2-diagrams)
provides *A Hyperlink-Capable D2 Diagram Rendering Capability*

**Setup `mdbook-d2`**

Install the `mdbook-d2` preprocessor with `cargo install mdbook-d2`, 
and append the following to `book.toml`:

```toml «append mdbook-d2 preprocessor configuration to book.toml»
[preprocessor.d2]
layout = "elk"
inline = true
```


[Inline Command Execution Preprocessor](./../../sandbox/ARCHITECTURE Sandpit/prototypes/architecture-book-prototype/src/example/01-oa-docs-01-mdbook.md#required-capability-using-commands-to-auto-populate-documentation)

**Setup mdbook-cmdrun**
   
Install the `mdbook-cmdrun` preprocessor with `cargo install mdbook-cmdrun`,
and append the following to `book.toml`.

```toml «append cmdrun preprocessor configuration to book.toml»
[preprocessor.cmdrun]
```
>   Append the following to `book.toml`:


[Mermaid Diagram Preprocessor]("./../../../../Documents/Daily Notes/RESOURCES.md|")
for Gantt Support.


### Note Tools

>  **open-note**: Opens a note `./open-note [DATE_TO_OPEN]` (`DATE_TO_OPEN` defaults to current date),
>                 and if not specified will create a note (if destination directory exists), 
>                 the `create-note` has the reponsibilitiy of making something present. The 
>                 `open-note` does not create a new environment, because we want creation to be an intentional act,
>                 by having an initial action, this ensures that `system-to-system` functions can be mapped
>                 more reliably.

```sh «open note»
#!/bin/sh

NOTE_DIRECTORY="${NOTE_DIRECTORY:-$HOME/Documents/Daily Notes}"

function open(){
  
  local filename=${1:-$(echo `date --iso-8601`.md)}
  
  if [ -d "$NOTE_DIRECTORY" ]; then     
    echo "Found directory: $NOTE_DIRECTORY"
  else 
    echo "NOTE_DIRECTORY not found. Try using `create-note` instead."
    return 1
  fi   

  local filepath="$NOTE_DIRECTORY/$filename"

  if [ -f "$filepath" ]; then
    echo "Opening: $filepath"
    nvim "$filepath"
    echo "Opened note: $filepath"
  else 
    ./create-note && nvim "$filepath"
  fi 

}
```

>   **create-note**: Creates notes and paths to the notes. 
>                    It takes a `$NOTE_DIRECTORY` env variable as a path,
>                    to provisions/configures new `NOTES_DIRECTORY`. 
>                    It also can take can argument to override the `$filename`.
>                    If the `NOTE_DIRECTORY` does not exist then it will be created and will 
>                    then cancel before taking a note.
>                    Opens the current days daily note, if already exists.

```sh «create note»
#!/bin/sh

NOTE_DIRECTORY="${NOTE_DIRECTORY:-$HOME/Documents/Daily Notes}"

function create(){
  
  local filename=${1:-$(echo `date --iso-8601`.md)}
  
  if [ -d "$NOTE_DIRECTORY" ]; then 
    echo "Found directory: $NOTE_DIRECTORY"
  else 
    echo "NOTE_DIRECTORY not found. Creating $NOTE_DIRECTORY..."
    mkdir -p "$NOTE_DIRECTORY"
    echo "Created $NOTE_DIRECTORY."
    return 1
  fi   

  local filepath="$NOTE_DIRECTORY/$filename"

  if [ -f "$filepath" ]; then
    echo "Found note: $filepath"
    return 0
  fi 

  touch "$filepath"
  echo "Created note: $filepath"

}

create

```

>   **update-summary.fish**: Takes all notes matching the `«YYYY-MM-DD».md` file name pattern 
>                            in the current directory, and generates a new `SUMMARY.md`.
>                            It sorts the notes into chapters by months.

```sh «update-summary.fish»
#!/usr/bin/env fish

# Step 1: Get all daily notes in reverse chronological order
set notes (fd -g "????-??-??.md" | sort -r)

# Step 2: Extract unique month headers (YYYY-MM)
set months (printf "%s\n" $notes | sed -E 's/([0-9]{4}-[0-9]{2})-.*/\1/' | uniq)

# Step 3: Generate formatted headers
printf "# Summary\n\n# Daily Notes\n\n"
for month in $months
    # Convert YYYY-MM to "Month Year" format
    set year (echo $month | cut -d'-' -f1)
    set month_num (echo $month | cut -d'-' -f2 | sed 's/^0//')
    set month_name (date -d "$year-$month_num-01" +"%B")
    echo "# $month_name $year"
    echo ""

    # Print entries for this month
    printf "%s\n" $notes | grep $month | while read note
        set date (basename $note .md)
        set formatted_date (date -d "$date" +"%A, %d %B %Y")
        echo "- [$formatted_date]($note)"
    end
    echo ""
end
```

The following configurations should be added to the notes `book.toml` configuration:

```toml «Append to autogenerated pages using SUMMARY.md»
[build]
create-missing = false
```

#### Deprecated

**The tinyproxy and configuration are being replaced (intentions are moving to a `caddyfile`).**

> **serve.sh**: Calls `mdbook serve`, however this might be best managed by `systemd units`.

```sh «previous daily notes serve command»
#!/usr/bin/env sh 
mdbook serve -p 3001
```

> **Tinyproxy Configuration File**
>
> File: `test-tinyproxy.conf`
>
> The configuration was listening to 'http://localhost:8888',
> which is where `oa://docs` (was current sandbox architectural docs), 
> and `oa://notes` the non-public repository, which this was first configured.
>
> The issue is that `tinyproxy` does not support `websockets` out of the box, and though 
> it would not be hard to do a work around, it is best to find a more coherent solution.

```conf «deprecated tinyproxy configuration»
User tinyproxy
Group tinyproxy
Port 8888
Listen 127.0.0.1
Timeout 600
DefaultErrorFile "/usr/share/tinyproxy/default.html"
StatFile "/usr/share/tinyproxy/stats.html"
Syslog On
LogLevel Info
PidFile "./tinyproxy.pid"
MaxClients 100
Allow 127.0.0.1
Allow ::1
ViaProxyName "tinyproxy"
ReversePath "/docs/" "http://localhost:3000/"
ReversePath "/notes/" "http://localhost:3001/"
ReverseOnly No
# BindSame Yes
ReverseMagic Yes
ReverseBaseURL "http://localhost:8888"
```

> **Task**: Setup `systemd units` to use configurations to ensure easy to extend scheme handling capabilities.

> **Task**: Fix issue where an issue with the preprocessor breaks
>           rendering of all the documents.

> **Task**: Also, need either, fork `mdbook-d2` so I can fix it to ignore the `literate codeblock annotations`
>          on the first line, or I can specify the structure of the document (like a heading with `Diagram: SOME DIAGRAM`,
>          which I can pass for.


### Capability: Persistent URI/URN/URL Resource Resolution Scheme 



### Capability: Literate Writing [**WIP**]

**`sed` command to extract literate code blocks**

```sh «literate codeblock extractor»
sed -nE '/^```[^«]+«[^»]+»$/,/^```$/p'
```

> **Note**: Next steps for 'LitBlocks'...
>
>   After a command `:lua vim.api.nvim_command(' .. "'" .. ':LitBlocks Get' .. GET_TOKEN_HERE .. ')'`
>   is built so that I can run '«Load LitBlocks»' to reload itself.
>
>    The next steps are building the argument with a new function, and to get the return value such that 
>    it strips the codefence. Once we get the first bit, we can add another user command to just 
>    do get but use `tail -n-1` and `head -n+2`.

```lua «Load LitBlocks»
-- Requirements: ✓ Running 'LitBlocks Get' -- defaults to getting all the codeblocks
--               that proceeds to ask if it to run the block inside the fence.
-- Requirements: ✓ `:LitBlocks Get «literate codeblock extractor»` it will return just that codeblock
-- Requirements: ✓ Use grep and sed, and other POSIX Compliant operations
vim.api.nvim_create_user_command('LitBlocks', function(action)
   -- Define the default pattern to match lines with code blocks formatted by the special characters
   local pattern = [[/^```[^«]+«[^»]+»$/,/^```$/p]]

   -- Default command to search for all matching patterns
   local cmd = ":w !cat | sed -nE '" .. pattern .. "'"

   -- Execute the command if the 'Get' parameter is passed to the action
   if action.fargs[1] == 'Get' then
       -- Concatenate all remaining arguments to form the block identifier key
       if #action.fargs > 1 then
           -- Join the remaining arguments to form the identifier
           local identifier = table.concat(action.fargs, " ", 2, #action.fargs)

           -- Adjust the pattern if a specific block identifier is given
           pattern = "/^```[^«]*" .. identifier .. "$/, /^```$/p"
           cmd = ":w !cat | sed -nE '" .. pattern .. "'"
       end
       vim.api.nvim_exec(cmd, false)
   end
end, { nargs = '+' })
```




## Appendix: Current Work In Progress


    **Plan**: Finish the writing up the mdbook setup and protocol scheme guide, 
              get the configuration moved work sandbox to here..
              Setup the remaining documents stores, to use 
              systemd to manage the other components.
              Upgrade the oa-tools to use the configuration to search 
              for codeblocks, and to be able to deploy them.
              TerminalAI capabilities.
              ...
              Continue with building the collections, to use the 
              meta components subsystem, to build the other component collections. 
              Use the component collections, to build out the infrastructure 
              to setup pipeline.
              ...
    
             
                

        ...
    ## Capability: TerminalAI 
    
    ** Can put instructions prior to message **
    Neovim -- TerminalAI integration 
    ```
    :'<,'>w !cat | wl-copy; set message "$(wl-paste)"; terminal-ai "$message"
    ```
    

    **Include the entr display thing**

    ### Service: XDG Custom Scheme Handler



    ### ENTR 

        ...

    ### Configuration

    ```sh «update fish shell config on change»
    echo "./shell-configurations/orchestration-architect.fish" | entr fish "oa-load-environment.fish"
    ```

    > **Task**: Add instructions for `bcachefs`, `fzf` and `zoxide`.

    > **Note**: The `weather.fish` comes from a literate specification draft.

    ```tree command output
    $XDG_CONFIG_HOME/fish
    ├── completions 
    │   └── bcachefs.fish *
    ├── conf.d
    │   ├── fzf.fish *
    │   ├── orchestration-architect.fish
    │   └── zoxide.fish *
    ├── config.fish
    ├── fish_variables
    └── functions
        ├── fish_prompt.fish *
        └── weather.fish    *

    ```



    **Configuration**

    Path `$XDG_CONFIG_HOME/terminal-ai`



    >   **NEED TO ADD CONFIGURATIONS**

        *Contents of the 'CONFIGURATION Sandpit'*

            DESIGN-XXX Literate Configuration
            oa-load-environment.fish
            prototypes
            shell-configurations
            SHELL-CONFIGURATIONS-CONTEXT.md
            TASKS-TO-ADD.md
            update-shell-config-on-change.md
            workspace-configuration



---




```sh «fzf-lit-block.fish»
#!/usr/bin/fish

# Ensure XDG_CONFIG_HOME is set
if not set -q XDG_CONFIG_HOME
    set -gx XDG_CONFIG_HOME "$HOME/.config"
end

# Set OA_CONFIG_PATH and ensure it exists
set -gx OA_CONFIG_PATH "$XDG_CONFIG_HOME/orchestration-architect"
if not test -d "$OA_CONFIG_PATH"
    mkdir -p "$OA_CONFIG_PATH"
end

# Create default search paths file if needed
set search_paths_file "$OA_CONFIG_PATH/codeblock_search_paths.conf"
if not test -e "$search_paths_file"
    # Create with default search paths
    echo "# Add search paths for literate code blocks (one per line)" > "$search_paths_file"
    echo "$HOME/Documents" >> "$search_paths_file"
    echo "$HOME/Documents/Daily Notes" >> "$search_paths_file"
    echo "# Example: /path/to/your/notes" >> "$search_paths_file"
end

# Load search paths
set search_paths
if test -e "$search_paths_file"
    while read -l line
        # Skip comments and empty lines
        if string match -qr '^[^#]' -- "$line" && test -n "$line"
            set -a search_paths "$line"
        end
    end < "$search_paths_file"
end

# Fallback to current directory if no paths defined
if test (count $search_paths) -eq 0
    set search_paths "."
end

# Define pattern for literate codeblocks
set pattern '^```[^«]+«[^»]+»$'

# Find files with literate codeblocks
set -l selected_file ( \
    rg --no-ignore --files-with-matches "$pattern" --glob '*.md' $search_paths 2>/dev/null | \
    fzf --height=80% --style=full --border --preview 'bat --style=numbers --color=always {}' \
)

if test -n "$selected_file"
    # Find all codeblock start lines
    set block_starts (rg -n "$pattern" "$selected_file" 2>/dev/null | \
        string replace -r '^([0-9]+):.*$' '$1' \
    )

    # Find matching end lines for each start
    set block_info
    for start in $block_starts
        # Find next closing codeblock after start line
        set end (rg -n '^```$' "$selected_file" 2>/dev/null | \
            string replace -r '^([0-9]+):.*$' '$1' | \
            while read -l line_num
                test "$line_num" -gt "$start" && echo "$line_num" && break
            end
        )
        
        # Extract tag from codeblock
        set tag (sed -n "$start p" "$selected_file" | \
            string replace -r '^.*«([^»]+)».*$' '$1' \
        )
        
        if test -n "$end" && test -n "$tag"
            set -a block_info "$start:$end:$tag"
        end
    end

    if test (count $block_info) -gt 0
        # Present tags in fzf for subselection
        set selected_block (printf '%s\n' $block_info | \
            fzf --height=40% --border --prompt="Select codeblock: " \
                --preview="set parts (string split ':' '{1}'); \
                    set start \"\$parts[1]\"; set end \"\$parts[2]\"; \
                    sed -n \"\$start,\$end p\" \"$selected_file\"" \
        )

        if test -n "$selected_block"
            # Parse selected block info
            set parts (string split ':' "$selected_block")
            set start "$parts[1]"
            set end "$parts[2]"
            set tag "$parts[3]"

            # Extract codeblock content
            set extracted_block (sed -n "$start,$end p" "$selected_file")

            # Display extracted block
            echo -e "\n\033[1;32mExtracted Code Block [$tag] from $selected_file:\033[0m"
            echo "$extracted_block"

            # Execution prompt
            echo -e "\nDo you want to execute the code block? (y/n)"
            read -P "" execute

            if test "$execute" = 'y'
                # Strip codeblock markers using head/tail
                echo "$extracted_block" | tail -n +2 | head -n -1 | bash
            end
        else
            echo "No code block selected."
        end
    else
        echo "No literate code blocks found in $selected_file."
    end
else
    echo "No file selected."
end
```

    ---
    IT GOES INTO `OA_TOOLS_PATH` and is symlinked to `$HOME/.local/bin/`
    **DRAFT**

    ARCHITECTURE -- BIG PICTURE
    | Information and        ^
    | Data Viewpoint         |
    | (where is everything)  | populate   
    SWBOK Operational Viewpoint: REQUIREMENTS -> DESIGN/MODELLING -> DEVELOPMENT -> VERIFICATION -> DEPLOYMENT 
    |creates stuff  -- now   | provide system+services+operation -> capabilitiea
    |                                   |_______/+|_____/+|_____/       systems make harder, services make easier.
    |to achieve this stuff  -- medium term 
    SYSTEM: Is the interaction of the ...    
    |
    | longer term 
    PROJECT VIEWPOINT:
    LITERATE CAPABILITY IS A PROGRAM... 
    THE PROGRAM IS RESPONSIBLE FOR A PART OF A PORTFOLIO,
    FOR DEVELOPING A PARTICULAR CAPABILITY WITHIN A CERTAIN SCOPE.
    THE CURENT SPRINT IS A PROJECT.
    
    
    
    # Capability: Fuzzy Find and Execute Literate Specification

    -- Bootstrap with `cat ...this_document... | tail -n1 | sh`
    -- It should have a 
    -- this should be posix, the other version is in the sandbox.
    set deploy-lit-spec $(sed '/^```«deploy fzf-lit-block.fish»$/,/^```$/p')
    set source-lit-spec $(sed -nE '/```«fzf-lit-block.fish»$/,/^```$/p')
    deploy-lit-spec >>> ... thats a tool to deploy lit-spec 
    ... use tool to trigger ...
    ... cat source-lit-spec | deploy-lit-spec


    IFS or something using configurations 
    and standards. put in [XDG_USER_DATA >=XDG_DATA]...

    ```literate «deploy fzf-lit-block.fish»
    #!/usr/bin/env sh 
    cat <<< END_OF_BLOCK
    ... find «fzf-lit-block.fish» ...
    END_OF_BLOCK > /tmp/deploy-fzf-lit-block.fish 
    ```


    
    

