[Orchestration Architect Overview](https://github.com/SuperPanda/orchestration-architect/wiki/Home)

## Tasks

[Kanban](https://github.com/SuperPanda/orchestration-architect/wiki/Kanban)

[Issues](https://github.com/SuperPanda/orchestration-architect/issues)

[Repo Structure](https://github.com/SuperPanda/orchestration-architect/wiki/Documentation-%E2%80%90-Development-Process-and-Structure)

## Repository Structure

[Aggregate of branch README](https://github.com/SuperPanda/orchestration-architect/wiki/Documentation-%E2%80%90-Branch-READMEs-%E2%80%90-Version-0.8)

### Branch `0.8.0-assets`

[Assets Branch](https://github.com/SuperPanda/orchestration-architect/tree/0.8.0-assets) - Stores assets and relevant metadata

[Grub Bootloader Assets](https://github.com/SuperPanda/orchestration-architect/wiki/Design-%E2%80%90-Grub-Bootloader-%E2%80%90-Assets)

> This needs to be added to LFS and tied to assets branch.

### Branch `0.8.0-seed`

The minimal or last previous version required files to migrate/build the pristine environment.
This process is to be automated with a CI/CD pipeline.

### Branch `0.8.0-pristine`

The workspace after bootstrapping the 0.8.0-seed branch. Updated via diffs between pristine and the bootstrapped 0.8.0-seed

### Branch `0.8.0-dev`

WIP filling this in
