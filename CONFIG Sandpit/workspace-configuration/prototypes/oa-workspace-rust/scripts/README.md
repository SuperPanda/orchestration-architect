# Git Processing Framework
```
Status: Working Draft
Objective: Composable functionality to realize the Architectural Design Decision (OA:ADR-CODE_EVOLUTION) to ensure that mechanisms are in place for the re-generation process.
```
## Notes
This section includes things just done quickly, that can be abstracted and generalised.

Clean up the repos from issues with the following code.
### Goal: Support Universal Emergent Property: Generative Effects
This involves creating a product of two generators, that with each generator providing the a manner to iterate of the homset of possible interactions.

#### Let's start looking at the intersection of two systems
##### Quick hack (stage 0: something that shouldn't even be looked at)
Looking at this script I used to remove a bunch of remote branches that were accidently being propagated.

This script takes a file and passes each line as an argument.
```process-file.sh (initial)
cat $1 | xargs -I"{}" git branch --remote -d {}
```

We shoud see that we have an interface being the file, and every interaction will need to ensure a stable interface between the arguments provided from state of the environment, and the operation. So in this case we have 

```remotes-to-delete.list
origin--mirror=fetch/0.8.0-documents
origin--mirror=fetch/0.8.0-initial
origin--mirror=fetch/0.8.0-pristine
origin--mirror=fetch/0.8.0-sandbox
origin--mirror=fetch/0.8.0-seed
origin--mirror=fetch/0.8.0-tests
origin--mirror=fetch/0.8.0-tools
origin--mirror=fetch/origin/0.8.0-sandbox
origin--mirror=fetch/pre-release_splash
```

And we have the generation of the files to process.
```cleanup-script.sh
./target/debug/worktree_setup --use-version 0.8.0 --target-directory /tmp/test --source-repository /srv/git/orchestration-architect.git | grep -E mirror | grep -oP "(\".*\")" | sed "s/\"//g" >> remotes-to-delete.list
```

And a bit of rust code (I firsted start programming in rust last night, so bare with me (and the second thing I've programmed in rust (first was the web server tutorial on the rust lang page)).

```get-branches.rs
use clap::Parser;
use git2::{Branch, BranchType, Branches, Repository};
use std::{fs,
          path::Path};

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {

    // The system version the workspace should load into the workspace
    #[arg(short, long)]
    use_version: String,
    // The target directory to create the worktree folders
    //
    #[arg(short, long)]
    target_directory:  String,
    
    // The mirrored (bare) repository for the project
    #[arg(short, long)]
    source_repository: String,
}

fn main() {
    let args = Args::parse();
    let (repository_path,version, worktree_target) = (args.source_repository, args.use_version, args.target_directory);

    println!("Looking for branches in {0} (Version {1}).", repository_path, version );

    // Check if path for workspaces exists, create if not
    let worktree_path = Path::new(&worktree_target);
    if !worktree_path.exists() {
        println!("Target directory does not exist. Creating...");
        let _ = fs::create_dir_all(worktree_path);
    }
    let repo = Repository::open_bare(&repository_path);
    let repo = match repo { 
        Ok(repo) => repo,
        Err(e) => {
            eprintln!("Error: {}",e);
            return;
        }
    };
    if repo.path().exists() {
        println!("Path: {}", repo.path().display());
    }
    println!("Bare: {}",repo.is_bare());
    let branches_results = repo.branches(None);
    let _branches_results = {
        match branches_results {
        Ok(branches) => {
            let branches = branches;
            for branch_result in branches {
                    match branch_result {
                        Ok(branch_result) => {
                            let (branch,branch_type) = branch_result;
                            let branch = branch;
                            let branch_type = format!("{:?}",branch_type);
                            let name = branch.name();
                            let name = format!("{:?}",name);
                            println!("[{}] {}",branch_type,name);
                        },
                        Err(e) => {
                            eprintln!("error: {}",e);
                        }
                    }
            }
        },
        Err(e) => {
            eprintln!("error: {}", e);
            return ();
        }
    }
    };
```

So my habit is to see something the list being like just the message, so thats not really important, but how we shape it is.

The command to run the files should really be more composable,
so lets see it as 
```
<STATE> ---SENSE_STATE---- <<ABSTRACT_PRODUCT_OPERATION>> 
        little composable                   |
        things that can be                 ACT
         extended easily                    |
                                         ACTIONS
```    
> Recommended reading: Marvin Minksky's Society of Mind,
and The Emotion Machine

Now lets use Category Theory and we can create a construction,
and then you will find that the same abstract structures
can apply to different domains.

But before that, I got to go restore all my tools I wiped off 
system for reasons I can't remember.


