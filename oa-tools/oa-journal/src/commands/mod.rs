// File: commands/mod.rs
pub trait Command {
  fn execute(&self);
}

pub mod tasks;
pub mod notes;
