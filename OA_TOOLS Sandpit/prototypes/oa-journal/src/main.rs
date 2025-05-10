// File: main.rs
use clap::{Parser,Subcommand};
use oa::commands::{tasks, notes, Command};

#[derive(Parser)]
#[command(name = "oa")]
#[command(version = "0.8")]
#[command(about = "CLI to manage tasks within orchestration architect")]

struct Cli {
    #[command(subcommand)]
    command: CommandType,
}

#[derive(Subcommand)]
enum CommandType {
    #[command(subcommand)]
    Tasks(tasks::Commands),
    #[command(subcommand)]
    Notes(notes::Commands)
}

fn main() {
  let cli = Cli::parse();

  match cli.command {
    CommandType::Tasks(cmd) => cmd.execute(),
    CommandType::Notes(cmd) => cmd.execute()
  }
}
   

