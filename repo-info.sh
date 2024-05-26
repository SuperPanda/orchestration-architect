#!/bin/bash

REPO_PATH="/srv/git/orchestration_architect.git"
WORKSPACE_PATH=~/orchestration_architect

# Check if the repository exists
if [ ! -d "$REPO_PATH" ]; then
  echo "Repository does not exist at $REPO_PATH"
  exit 1
fi

# List all branches in the bare repository
echo "Branches in the bare repository:"
git --git-dir="$REPO_PATH" branch -a

# Show the remote origin URL
echo "Remote origin URL:"
git --git-dir="$REPO_PATH" remote -v

# List worktrees
echo "Worktrees:"
git --git-dir="$REPO_PATH" worktree list

# For each workspace, show branch and remote
for workspace in $(ls "$WORKSPACE_PATH"); do
  if [ -d "$WORKSPACE_PATH/$workspace/.git" ]; then
    echo "Workspace: $workspace"
    echo "Branch:"
    git -C "$WORKSPACE_PATH/$workspace" branch
    echo "Remote origin URL:"
    git -C "$WORKSPACE_PATH/$workspace" remote -v
    echo "-------------------------------------"
  fi
done

