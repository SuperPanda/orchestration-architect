# Repository Setup and Configuration

> **Document Scope**: This is about setup and configurations of repositories.

> **Task**: This does not include everything, need to import everything.


## Create a new repository for the first time

This is basically how it works. 

> **Task**: Add information on users and groups.

```sh «example for create initial repo»
#!/usr/bin/env sh

# Configurations
NEW_REPO_NAME="${1:-"a-test-repo"}"
REPO_DIR="${2:-/tmp/repos}"
WORKSPACE_DIR="${3:-$REPO_DIR}"

# Build Path Variables
REPO_PATH="$REPO_DIR/$NEW_REPO_NAME.git"
WORKSPACE_PATH="$WORKSPACE_DIR/$NEW_REPO_NAME"

echo "Set NEW_REPO_NAME to '$NEW_REPO_NAME'"
echo "Set REPO_PATH to '$REPO_PATH'"
echo "Set WORKSPACE_PATH to '$WORKSPACE_PATH'"

echo "Creating '$REPO_PATH' and '$WORKSPACE_PATH'..."
mkdir -p {$REPO_PATH,$WORKSPACE_PATH}
echo "Created '$REPO_PATH' and '$WORKSPACE_PATH'..."

cd "$REPO_PATH" || exit 

git --git-dir="$REPO_PATH" init --bare && echo "Successfully initialised bare repo '$REPO_PATH'"


# Creates '$REPO_PATH/refs/heads/initial' in an idempotent way.
if [[ ! -f $REPO_PATH/refs/heads/initial ]]; then

    # Ensure the next command line is moved out of this execution branch if you want to have 'git init' 
    # and have it automatically update templates, etc.
    git --git-dir="$REPO_PATH" worktree add "$WORKSPACE_PATH/initial" --orphan -b initial \
        && echo "Created 'initial' branch and added worktree to '$WORKSPACE_PATH'"
    git --git-dir="$REPO_PATH" --work-tree="$WORKSPACE_PATH/initial" commit -m "Initial commit" --allow-empty \
        && echo "Created 'initial' empty commit."
else
    echo "Skipping Initial Branch Setup as it already exists."
fi 

# This is how I create branches that points to the `initial` branch.
# git --git-dir="$REPO_PATH" worktree add "$WORKSPACE_PATH/notes" -b "notes" initial 

# could use lock on a worktree when the worktree is transient to prevent pruning.
# setup master pgp key from authoriative controller, 
# and sign each user@machine key? or just user key? 

# Need to support moving repos, or locking a worktree while its offline.
```

> **Note**: If you manually move a linked worktree, 
>           you need to update the gitdir file in the entry’s directory.
>
>           For example, if a linked worktree is moved to /newpath/test-next 
>           and its .git file points to /path/main/.git/worktrees/test-next,
>           then update /path/main/.git/worktrees/test-next/gitdir 
>           to reference /newpath/test-next instead.
>           Better yet, run git worktree repair to reestablish the connection automatically.
>
>           Source: https://git-scm.com/docs/git-worktree

## Map Worktrees to Workspace



> **Task**: Replace the worktree stuff with the above. 


```text «example worktree-workspace map»
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

```sh «broken reference implementation that builds the system»
#!/bin/sh

#LOCAL_WORKSPACE="$HOME/repos/orchestration-architect"
#USER_REPO="$HOME/repos/orchestration-architect.git"


LOCAL_WORKSPACE="/tmp/repos/orchestration-architect"
USER_REPO="/tmp/repos/orchestration-architect.git"

while IFS=' ' read -r branch ref; do
  cd "$USER_REPO" || exit
  git worktree add "$LOCAL_WORKSPACE/$branch" "$ref"
done <<< EOF
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
EOF 
```


## Next Tasks

> **Task**: Discuss orphan branches allow for separate histories (could be useful for self-assembly or rebuild repo)

> **Task**: Discuss detached branches can be used 

> **Task**: Discuss how I could make a MULTI-REPO by having an orphan for each branch.

> **Task**: Discuss how orchestration Architect repos should setup multi-repos to separate public and private repos 

> **Task**: Discuss how important the need to write tests that it works correctly for private repos.

> **Task**: Discuss how this can be used to generate a diff for throw away branches should be in detached worktrees 

> **Task**: Discuss how I could use git templates, git hooks, maybe consider using ticketref hooks to link 
>            to `oa:projects#OA_PROJECT` [](<oa://docs/architecture/PV-1#all-Projects/OA_PROJECT>).
>
>           Resources: <https://git-scm.com/docs/githooks>

> **Task**: Discuss how I should lock transient worktrees

> **Task**: Add Remotes Workflow.

> **Task**: Remote access `https://git-scm.com/book/en/v2/Git-on-the-Server-Git-Daemon`
