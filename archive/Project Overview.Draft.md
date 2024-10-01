# Orchestration Architect (Draft)

## Overview

Orchestration Architect  is an experimental project aimed at managing complex systems through Infrastructure as Code (IaC) principles. This project distinctively incorporates applied category theory to structure and manage architecture and orchestration in the digital realm, aiming to create a system orchestration framework that is robust, scalable, and innovative.

Key Features of the Project:

- **Ansible Integration**: Built on Ansible for system management and orchestration, focusing on the composition of interacting components.
- **Modular Design**: The project is structured for modularity, with easy configuration adjustments made possible through variable files.
- **Roles and Responsibilities**: Includes roles for bootstrapping, LUKS key management, storage pool handling, KVM environment provisioning, network configuration, and the generation of custom bootable Linux distributions.
- **Self-contained**: Each part of the system has been built within the system, for the purposes of capturing the abstract relations. The entities of the system are not important, its the relationships. If it looks like a duck and sounds like a duck, then it is isomorphic to a duck. Capture the structure of how it changes in one frame of reference, mapping to another. Structures that can be captured allow it to be represented or used in different ways, visual models, documentation, code, a graph to data, all the same structure, and with any construct being able to be used in different domains.
- **User-Centric**: The User-centric philosophy from the Arch Linux culture
- **Clarity**:
- **Maintainable**: With many features, comes much maintainence, by ensuring universal properties, designs are automatically available or applicable to the entire system. 
- **Multiplicative Feature Composition**: Every feature, improves the possibility space from n! -> (n+1)! And by bundling the components together you create a hierachary of system detail.
- **Encrypted Block Storage**: Manages encrypted block storage with features for snapshotting and rollback, enhancing data security.
- **Holistic Behaviour**: Avoid dealing with edge cases by ensuring the systems can be clearly defined in a way that behaviour handles the system (for example instead of ensuring something is within the allowed bounds, make the object a lens into the different space). 
- **AI**: AI is not used to replace human innovation, but to complement the process of understanding. Human review is essential and to prevent the loss of joy and wonder, the AI has been designed to make you think you want, instead of providing the answers.
- **Emergence through application of Universal Properties**: Guided by the universal properties of category theories, novel and innovative takes on common practices, allow ideas to be explored, challenged, and truly understood. The Universal Properties allow the constructions to be able to flow between representations.
- **Systematic Introspection**: The System uses the tools of category theory to be able to not only represent itself, but use its internal representation and models to build upon itself.
- **Self-bootstrapping, self-documenting, self-healing**: Builds itself from the operating system you use to the code it runs, it can generate itself at different system levels. 
- **Persistence Transience**

## Old Stuff
The project is focused on transparency in infrastructure management, emphasizing practices that are self-documenting to ensure clarity and ease of maintenance. It's designed to facilitate the exploration of different configurations, and technical users who require a system that allows them to design, manage, and deploy infrastructure from text files, enabling them to test changes in a virtualized environment before deploying them to production. Or to bench mark different configurations.
Orchestration Architect Ansible is a learning/experimental project designed to manage complex systems through Infrastructure as Code (IaC) principles. This project uniquely employs applied category theory to structure and manage Ansible roles, creating a robust, scalable, and understandable system orchestration framework. 

This project leverages Ansible to manage and orchestrate systems through the composition of interacting components. It includes roles for orchestrating the bootstrap process, managing LUKS keys, handling storage pools, provisioning KVM environments, configuring networks, and generating custom bootable Linux files. The project structure is designed for modularity, allowing easy configuration through variable files.
This project illustrates managing complex systems using Infrastructure as Code (IaC), extending its capabilities to include the creation, administration, and testing of encrypted block storage with snapshot and rollback features. It encompasses a customizable in-memory Arch Linux OS build pipeline and a comprehensive suite for virtual machine management. The system supports live system emulation under KVM, complete with a software-defined networking infrastructure, facilitating robust CI/CD pipelines. Additionally, it features an OS Builder, a PXE Server, network and memory overlay file systems, and a network manager. The infrastructure is managed in a way that's transparent to organizations, emphasizing self-documenting practices for clarity and ease of maintenance.

In other words, you can use it to design, manage, and have redeployable infrastructure from a text file, and have multiple environments where production using bare metal systems on a physical network can be changed, tested in a hypervisor with software defined network, then deployed after validation.

## Theoretical Underpinnings

The project adopts concepts from category theory to structure and manage configurations, leading to a system that is both logically sound and practically efficient. Key principles include:

### Objects and Morphisms

- **Objects**: Representing system states, such as a locked/unlocked LUKS device or a mounted/unmounted BTRFS filesystem. In our context, objects is the desired configuration. A task file will be named as a desired configuration (roles/tasks/unlocked.yml).
- **Morphisms**: Morphisms are the steps to achieve a configuration, facilitating transitions between different states of an object. For instance, a morphism might be the transition of a storage volume from unencrypted to encrypted (LUKS) or manage the lifecycle of a BTRFS subvolume.
- **Functors**: These map objects and morphisms from one context (category) to another, providing a powerful way to abstract complex operations. For instance, mapping a storage path to a LUKS-encrypted path if the LUKS role is active.
- **Natural Transformations**: Demonstrated in the interactions between roles. For example, how the state of a LUKS container (locked/unlocked) affects the accessibility of a BTRFS subvolume. These represent interactions between functors, such as the impact of unlocking a LUKS volume on the accessibility of a BTRFS filesystem.

### Composability and Idempotency

- **Composability**: Our roles are designed to be composed together in a sequence, allowing for complex configurations to be built from simpler, reusable components.
- **Idempotency**: A key feature in Ansible and our design, ensuring that roles and tasks can be run multiple times without changing the outcome beyond the initial application.

### Design Decisions

- **Fail fast**: We want to provide assertions for expected parameters, be overly strict with assertions, then reduce if needed. Rather something not work, then work in unexpected ways.
- **Routing via main.yml**: Each role's `main.yml` acts as a router, directing Ansible to the appropriate task files based on the state of the system. This routing mechanism ensures modularity and clear state management.
- **Standardized Data Formatting**: The roles are designed to format and pass data consistently, ensuring that each state transition receives the context needed for accurate execution.
- **Info State**: Utilized to gather and display the system's current configuration and state, based on the configuration parameters provided to a role. It provides valuable starting point for developing new roles, as the info state is routed through the main.yml task which will structure the data, meaning other states will have a predictable interface by means of getting the info state to work first, and also allows to see configurations that might have been missed. Other common states are: 'present', 'absent', ...

## Usage (ehh.. not ready yet)

1. Clone the repository.
2. (Optional) Run `./setup-tmux.zsh` for development environment
3. Run `./setup-ansible.sh`

### Getting Started

#### Clone the Repository:

```bash
git clone https://github.com/SuperPanda/orchestration-architect.git
```

#### Transient Isle of Stability in Chaos, Repeating Structure, Fractal-Inspired Design, Self Reflection

#### Configure Bootstrap Variables:

Update vars/bootstrap_vars.yml with relevant configuration for orchestration.

## Project Structure

```
project_root/
│
├── playbooks/
│   └── ... (list of playbooks)
│
├── roles/
│   └── ... (list of roles)
│
├── vars/
│   └── ... (list of variable files, definition of networks, or reusable compositions)
│
├── templates/
│   └── ... (list of template files)
│
└── vault/
    └── ... (list of vault files)
```

### Roles

- **Storage Role**: Manages different storage configurations, providing a unified interface for filesystem and encrypted volume management.
- **LUKS Role**: Handles encrypted volumes, with tasks representing morphisms for encryption-related actions.
- **BTRFS Subvolumes Role**: Manages BTRFS filesystems, showcasing the application of category theory in filesystem management.
- **Network Roles**: Sets up network configurations using Open vSwitch, allowing for sophisticated network setups.
- **KVM Role**: Facilitates virtual machine management using libvirt, with integration into Open vSwitch networks.
- **Archiso Role**: Designed for creating custom Arch Linux ISOs for various purposes, including PXE boot environments, live systems, usb.

### Task Routing and Data Formatting

- **Main.yml Routing**: Acts as a router directing to specific task files based on the state, demonstrating functorial behavior in task execution.
- **Standardized Data Format**: Ensures consistency and predictability in the way data is passed and processed across different roles.

## Short-Term Objectives

1. **Refine Storage, LUKS, and BTRFS Roles**: Enhance these roles to ensure seamless integration.
2. **Migrate Features from 00_enc_blkdev Role**: Transition features to the new roles following the updated design principles.
3. **Network and KVM Role Development**: Implement and align network roles for advanced configurations and integrate the KVM role for VM management.
4. **Archiso Role Alignment**: Align the Archiso role with the project's design philosophy, enabling the creation of custom OS images for various use cases, including PXE booting. Package cache configurations.
5. **Bootstrapping v0.1**: Finalize the project's foundation, leading to the first significant release.
6. **Network and KVM Integration**: Align these roles to follow design principles
7. **Archiso Role**: Align the Archiso role with category theory principles for custom OS image creation. Allowing to experiment with different configurations, and build nvim, zsh configurations, etc.

## Next Steps

- **Support for Raspberry Pi Images**: Extend the project to support Raspberry Pi devices because the video out is busted and being to pxeboot an image with ssh configured would be useful
- **PXE Boot Environment**: Develop a PXE boot environment for automated provisioning of custom OS images.
- **Live System Migration**: Allow running systems to migrate between two environments live
- **Efficient Package Management**: Implement package caching for Arch Linux to optimize resource usage.
- **Proper CI/CD pipeline**: Implement CI/CD pipeline, add tests.

## Contributing

We welcome contributions from those interested in Ansible, system orchestration, and applied category theory. This project is not only a practical orchestration tool but also a learning platform for these emerging and intersecting fields.

## System Design Considerations

### Flexibility and Extensibility

The project prioritizes flexibility and extensibility to accommodate diverse infrastructure requirements. Each role is modular, allowing users to adapt and expand functionality as needed.

### Security

Security is a core consideration, especially in roles like `enc_blkdev_provision` and `luks_key_management`. The project aims to ensure the secure management of encrypted data and encryption keys.

## License

This project is licensed under the MIT License.
r
