```file:setup-worktree
#!/bin/sh

LOCAL_WORKSPACE="$HOME/repos/orchestration-architect"
USER_REPO="$HOME/repos/orchestration-architect.git"

while IFS=' ' read -r branch ref; do
  cd "$USER_REPO" || exit
  git worktree add "$LOCAL_WORKSPACE/$branch" "$ref"
done
```

Generate the following using `:read !<COMMAND>` and add the names of the folder names in your workspace.

```sh
git --git-dir=/srv/git/orchestration-architect.git branch -l
```

```file:workspace.config
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
