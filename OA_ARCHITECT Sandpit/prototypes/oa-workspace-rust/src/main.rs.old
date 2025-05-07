use clap::Parser;
use git2::{Branch, BranchType, Branches, Repository};
//use regex::Regex;
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
 // println!("{}",branches_results
 // for branch in branches_results {
 //     match branch {
 //     //match branch_result {
 //     (b, t) => {
 //                 let (branch, branch_type) = (b,t);                    
 //                 println!("[{}], {}", branch_type, branch.get().name());
 //                 return (b, t);
 //         },            
 //          BranchType::Remote => {
 //             eprintln!("Error: {}",result);
 //             return ((),());
 //         }
 //     }
 // }
}

