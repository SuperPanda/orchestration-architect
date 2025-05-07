
# Configuration Files 

> **TODO**
>
> - Set up the Tools, Workspace, User Repos Path, System Repos Path.
> - Need to map the types of configurations that exist
> - Decide on how precedences work for configurations.
> - Need to restructure

## The `XDG_BASE_DIR` Specifications

These need to be configured:

```
User Directories
----------------

   XDG_CONFIG_HOME
        Where user-specific configurations should be written (analogous to /etc).
        Should default to $HOME/.config.

    XDG_CACHE_HOME
        Where user-specific non-essential (cached) data should be written (analogous to /var/cache).
        Should default to $HOME/.cache.

    XDG_DATA_HOME
        Where user-specific data files should be written (analogous to /usr/share).
        Should default to $HOME/.local/share.

    XDG_STATE_HOME
        Where user-specific state files should be written (analogous to /var/lib).
        Should default to $HOME/.local/state.

    XDG_RUNTIME_DIR
        Used for non-essential, user-specific data files such as sockets, named pipes, etc.
        Not required to have a default value; warnings should be issued if not set or equivalents provided.
        Must be owned by the user with an access mode of 0700.
        Filesystem fully featured by standards of OS.
        Must be on the local filesystem.
        May be subject to periodic cleanup.
        Modified every 6 hours or set sticky bit if persistence is desired.
        Can only exist for the duration of the user's login.
        Should not store large files as it may be mounted as a tmpfs.
        pam_systemd sets this to /run/user/$UID.

System Directories
------------------
    XDG_DATA_DIRS
        List of directories separated by : (analogous to PATH).
        Should default to /usr/local/share:/usr/share.

    XDG_CONFIG_DIRS
        List of directories separated by : (analogous to PATH).
        Should default to /etc/xdg.
```

## Configuration Systems

```
    OA_CONFIG_HOME: Contains sensitive 
```

### Orchestration Architect Configurations

**Current Location**: `$HOME/.config/orchestration-architect/`
**Desired Location**: `$XDG_CONFIG_HOME/orchestration-architect/`

**Task**: `$XDG_CONFIG_HOME` is not set. It needs to be setup, when building the system.
**Task**: Set `$OA_CONFIG_HOME` to the desired location.


### TerminalAI Configurations 

**Current Location**: `$HOME/.config/terminal-ai/`
**Desired Location**: `$XDG_CONFIG_HOME/terminal-ai/`

**Task**: Set `$TAI_CONFIG_HOME` to be at desired location.

**Configuration Files**

- `$TAI_CONFIG_HOME/.env` holds the api keys for an API secrets
- `$TAI_CONFIG_HOME/config` holds the configuration for TerminalAI


**Current Content for `$TAI_CONFIG_HOME/config`**

```sh
TRANSCRIPT_PATHS=$HOME/repos/terminal-ai-transcripts/default/
```

**Task**: Change `$TAI_CONFIG_HOME/config` to `$TAI_CONFIG_HOME/config.sh`

**Task**: Separate .env to .openai.env and add .deepseek.env 

**Current content of `$TAI_CONFIG_HOME/.env`**

```env
setenv OPENAI_PROJECT_ID XXXXXXXX
setenv OPENAI_API_KEY XXXXXXXX
```


**Current content of `$OA_TOOLS_PATH/activate-terminal-ai.fish`**

```fish
source ~/.config/terminal-ai/.env
```

**Current content: `$OA_TOOLS_PATH/activate-terminal-ai`**

```bash 
#!/bin/bash
# File: ./scripts/activate-orchestration-architect
ORCHESTRATION_ARCHITECT_HOME="$HOME/orchestration_architect"
OPENAI_ENV_FILE_PATH="$HOME/keystore/api-keys/openai"

# Check if OPENAI_ENV_FILE_PATH exists
if [ ! -f "$OPENAI_ENV_FILE_PATH" ]; then
    echo "Error: OPENAI_ENV_FILE_PATH ('$OPENAI_ENV_FILE_PATH') does not exist."
    echo "Please add OPENAI_API_KEY and OPENAI_PROJECT_ID to the file."
    echo "Example:"
    echo "export OPENAI_API_KEY=\"your_api_key_here\""
    echo "export OPENAI_PROJECT_ID=\"your_project_id_here\""
    exit 1
fi

# Load environment variables
eval "$(cat $OPENAI_ENV_FILE_PATH)"
export OPENAI_API_KEY=$OPENAI_API_KEY
export OPENAI_PROJECT_ID=$OPENAI_PROJECT_ID 

# Add orchestration architect scripts to PATH

NEW_PATH="$ORCHESTRATION_ARCHITECT_HOME/scripts:$PATH"

if [ -d "$NEW_PATH" ] && [[ ":$PATH:" != *":$NEW_PATH:"* ]]; then
  export PATH="$NEW_PATH:$PATH"
fi
```

*Current contents of `$XDG_CONFIG_DIR/fish/config.fish`**

```
if status is-interactive
    # Commands to run in interactive sessions can go here
    set OA_TOOLS_PATH $HOME/repos/orchestration-architect/tools
    set EDITOR nvim
    set -a PATH $OA_TOOLS_PATH
    set -a PATH $HOME/.local/bin
    set -a PATH $HOME/.cargo/bin
    source $OA_TOOLS_PATH/activate-terminal-ai.fish
end
```

**Task**: Need to move content out of `$XDG_CONFIG_DIR/fish/config.fish` and restructure it that considers maximal compatibility between sh, bash, zsh and fish.
