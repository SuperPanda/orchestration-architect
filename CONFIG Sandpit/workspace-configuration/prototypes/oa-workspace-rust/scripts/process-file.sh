cat $1 | xargs -I"{}" git branch --remote -d {}
