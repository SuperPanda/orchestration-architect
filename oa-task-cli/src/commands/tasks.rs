use clap::{Args,Parser,Subcommand};
use super::Command;


#[derive(Subcommand)]
pub enum TaskCommands {
   Add(AddTaskArgs),
}
   

#[derive(Args)]
pub struct AddTaskArgs {
  #[arg(short,long,required=true)]
  title: String,
}

pub fn add_task(arguments: &AddTaskArgs) {
    println!("{0}", arguments.title);    
    todo!("Add task.")
}

impl Command for TaskCommands {
    fn execute(&self) {
        match self {
           TaskCommands::Add(arguments) => add_task(&arguments)
        }
    }
}

   

