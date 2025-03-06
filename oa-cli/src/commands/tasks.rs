// File: commands/tasks.rs
use clap::{Args,Subcommand};
use crate::commands::Command;
use crate::resources::{resolver,constants::TASKS_NAMESPACE};


#[derive(Subcommand)]
pub enum Commands {
   Add(AddCommandArguments),
   List(ListCommandArguments),
}
   

#[derive(Args)]
pub struct AddCommandArguments {
  #[arg(short,long,required=true)]
  title: String,
}

#[derive(Args,Debug)]
pub struct ListCommandArguments {
    #[arg(short,long)]
    filter: Option<String>
}

fn create(arguments: &AddCommandArguments) {
    println!("{0}", arguments.title);    
    todo!("Add task.")
}

fn list(arguments: &ListCommandArguments){
    println!("{:?}", arguments);
    resolver::query(&TASKS_NAMESPACE);
}

impl Command for Commands {
    fn execute(&self) {
        match self {
           Commands::Add(arguments) => create(&arguments),
           Commands::List(arguments) => list(&arguments),
        }
    }
}

   

