// File: lib/constants.rs

use lazy_static::lazy_static;

pub const WORKSPACE_PATH:&str = "/home/panda/repos/orchestration-architect";

pub const NOTES_NAMESPACE:&str = "oa:notes";
pub const TASKS_NAMESPACE:&str = "oa:tasks";

lazy_static!{
    pub static ref NOTES_DIRECTORY: String = format!("{0}/{1}",WORKSPACE_PATH,"documentation/Development Journal/Notes");
}

