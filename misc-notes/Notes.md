
# Script WIP

## Resources
lots of discussions involving current state of system on 2024-07-29.md
probably a lot more in the logs from openai
## Introduction

This document outlines the design and functionality of a comprehensive system that employs QEMU, containers, various virtual environments, and storage configurations to achieve a modular and composable infrastructure. The goal is to provide a highly flexible, automated, and self-repairing system driven by human-centric specifications.

## Components and Terminology

- **QEMU**: Referred to as a "Hypervisor." It enables running a virtualized environment for testing Arch Linux builds on a USB without continual updates.
- **Container**: A broad term used to represent different virtualization methods like `nspawn`, `chroot`, `jails`, `LXC`, and `libvirt`.
- **Roles**: Defined as distinct functionalities or services managed by the system.
- **Storage**: Includes file_block_image, loopback_device, and Btrfs volume management, among others. These are used for creating and managing portable volumes and testing environments.
```
TODO: ADD MORE AND FIX ABOVE
```
```
TODO: PROBABLY BETTER TO DESCRIBE THE DESIGN AND CATEGORY THEORY
AND HOW FUNCTIONALITY EMERGED THROUGH THE COMPOSABILITY
```
## System Hierarchy and Functionality

### Modular Roles

```
should start with motivation, and reference all the different 
hacks and vulnerabilities, and how as not only as an industry,
but the culture from open source libre-folk, to industry,
we need to take more care in what we do and truely understand
and explore the code they use. Everything that is building this project,
is done on the system. 

AI is sapping and corporations are making us dependent on the tools,
and you wait, when the bubble is over, prices will sky rocket.
TerminalAI empoweers you to practice communicating to the duck,
and the quality of the explanation is reflected back at you. 
A lot of ideas ebb and flow, but this system is able to capture it all,
and hopefully using embeddings, and a little bit of vector calculus,
annd graph theory; in conjunction of category theory.

Every bit of the code had the intent to be human readable, and to be honest,
I use AI mostly to get my thoughts onto the screen quicker, so I can think faster,
but taking the time to name everything as best as possible, and having to describe the 
ideas you have and the rationale, means things are just better thought out.

Learn some higher level mathematics today, some abstract algebra, topology, and category theory
hurt no body; and even if its tedious, just watch a video here and there,
read some articles, slowly go through a book, and try and put it into pratice.
Skim the topics, try and use the what you picked up even if you dont on a project.
Then once you had a go, and then watch some more, but remember to go back to the earlier
stuff and you will discover how much you missed.

Also Sleep, Exercise and eat plenty of protein and fibre. And try to get at least one 
human interaction a week :)

Recommended Books:
Marvin Minsky - Society of Mind
Sync - ...



WRONG. Should start with collections and how there is usually a higher level of abstraction,
in each collection, where the higher level specifications, delegate the 
the the relevant specification in a standardise way.
Need to talk about... lots. But also how that the Meta Components 
make the functors and the design allow not only for composition,
but allows all the parts to change like axle turns a wheel,
the driver turns have to tell the wheel to turn, you just stick a wheel
on an axle and it turns (improve the analogy).
The use of adjunctions by ensuring the present, absent and info (morphisms), 
allow for the self system bootstrap, and returning to the seed, allowing effortless
migration and building and recovering the systems. 
then security....

```
1. **Hypervisor Role (QEMU)**:
    - Facilitates running Arch Linux builds in a virtualized environment.
    - Reduces the need for continual updates by isolating the environment.

```
WRONG
```
2. **Container Role**:
    - Implements various container technologies (`nspawn`, `chroot`, `jails`, `LXC`, `libvirt`) as separate roles.
    - Provides the framework for creating different virtual environments.

3. **Storage Role**:
    - Manages storage using `file_block_image`, `loopback_device`, and Btrfs subvolumes.
    - Supports ephemeral systems using `tmpfs` for temporary file storage.
    - Allows the creation of portable volume pools.

### Playbooks and Tasks

- **Playbooks**:
    - Convert to roles for modular automation.
    - Handle the creation of block device images, testing environments, and storage pools.
    
- **Tasks**:
    - Defined in `main.yml` and route based on provided state parameters.
    - Implement functors at higher abstraction levels with morphisms to ensure consistency.
    - Support states like `present`, `absent`, and `info`.

### Automation and Self-Repair

- **Meta Template Role**:
    - Ensures consistency and embeds fragments.
    - Preserves user modifications while maintaining concerted system movement.

- **Bootstrap and Self-Repair**:
    - Enables components to bootstrap independently.
    - Uses `present` and `absent` states to construct and repair systems.

## System Architecture and Orchestration

- **Live USB Master Control System**:
    - Generated using `mkarchiso` roles and playbooks.
    - Provides security hardening (SSH, ACL, PAM) and operates in RAM with locked configuration.
    - Persistence layer on a separate LUKS-encrypted partition.

- **User Management**:
    - Single system user account managed by injecting a public key on boot.
    - System user account resides on the master control live USB.

## Human-Centric Specification

- **Configuration**:
    - Driven by human-centric specification files.
    - Ensures easy and intuitive management of the entire system.

- **Tooling**:
    - Integrated with Neovim scripts and other scripts for terminal and text editing interactions.
    - Facilitates interaction with GPT-3 for enhanced workflow and accuracy.

## Version Control and Automation

- **Git Repositories**:
    - Manages deployment and self-updating of systems.
    - Ensures all components, including roles, playbooks, and storage configurations, are version-controlled and architected.

In summary, this system provides a highly flexible and automated infrastructure capable of managing complex virtual environments and storage configurations. Its design ensures modularity, consistency, and self-repair, driven by human-centric specifications and robust tooling, all organized under version control for seamless operations and management.
---
