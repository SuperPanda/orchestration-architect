// File: commands/notes.rs
use clap::{Args,Subcommand};
use crate::commands::Command;
use crate::resources::{constants::NOTES_NAMESPACE,resolver};

#[derive(Subcommand)]
pub enum Commands {
   Add(AddCommandArguments),
   List(ListCommandArguments)
}
   

#[derive(Args)]
pub struct AddCommandArguments {
  #[arg(short,long,required=true)]
  title: String,
}


#[derive(Args,Debug)]
//
pub struct ListCommandArguments {
    #[arg(short,long)]
    filter: Option<String>
}



fn create(arguments: &AddCommandArguments) {
    println!("{0}", arguments.title);    
    todo!("Add note.")
}

fn list(arguments: &ListCommandArguments){
    println!("{:?}", arguments);
    resolver::query(&NOTES_NAMESPACE);
    todo!("List Notes")
}


impl Command for Commands {
    fn execute(&self) {
        match self {
            Commands::Add(arguments) => create(&arguments),
            Commands::List(arguments) => list(&arguments),
        }
        
    }
}

   

