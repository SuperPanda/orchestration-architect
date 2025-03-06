use clap::Subcommand;

pub trait Command {
  fn execute(&self);
}

pub mod tasks;
