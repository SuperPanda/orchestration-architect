# Orchestration Architect

  - Architectural Design Decision: Emergent Architecture - A Product of System Hierarchy and Domain Heteroarchy  

    - Need to ensure to maximise coefficient between functionality space via composition, and complexity as a function of number of products. I.e. compose small units, to form bigger units, but changes are loosely coupled but tightly cohesive. See examples relative to composable configuration, and then those collections can be used to make a higher order system

    - Architecture Matrix should cluster different domains, and there morphisms, see the notes in Julia somewhere

    - Hints at using an Ontology or Semantic Multigraph

  - Themes

    - Local Isle of Entropic Stability in a Sea of Chaos

    - Emergence through Universal Properties

    - Generative and Distillative Adjunctors for Resilience, Self-Healing and Self-Verification: Grow, Improve and Procreate using Adjunctions

    - Multiple the Features, not the Complexity

# Collections

  - Synopsis

    - Collections fall into two categories: (1) 'OA Modules' which map specifications to configuration parameters such that each collection will allow for configuration of subsystems used to build a large system; and (2) 'OA Systems' which at the time of writing, is used for prepared system configurations that form the initial system architecture envisioned.

      - TLDR: Collections.OA_Modules = Roles like Storage and Network that can be used to reproducibly rebuild infrastructure from a yaml file.

      - TLDR: Collections.OA_Systems = Playbooks that build the system the OA System runs in, like a live persistent USB or PXE Booted RAM Hypervisor in OA System.

    - All Fully Qualified Collection Names are under `orchestration_architect.<COLLECTION>`

  - OA Systems

    - OA000 Restore, Recover, Rebuild

    - OA001 Encrypted Master Control Node

      - Profile 1: Persistent LiveUSB

        - Build Environment: Artifacts Storage

        - Target: Any Block Device accessible via emulation or bare metal

      - Profile 2: Ephemeral Emulation

        - Build Environment: Loop device file in ephemeral RAM backed storage

        - Target: Any device accessible to the container runtime.

    - OA002 Ephemeral Transient Immutable RAM-backed Hypervisor

    - OA999 Demo System

  - OA Modules

    - 'Runtime' Collection

      - runtime.qemu

      - runtime.nspawn

    - 'Storage' Collection

      - Roles

        - storage.storage

          - Parameters: btrfs_subvolume, mount_table, filesystem, loop_device, luks, partition_table

          - Usage: `ansible.builtin.include_role: name=orchestration_architect.storage.storage storage_mount_table= {...} storage_state='mounted'

          - States: ... list states ...

        - storage.btrfs_subvolume

        - storage.mount_table

        - storage.filesystem

        - storage.loop_device

        - storage.luks

        - storage.partition_table

    - 'Meta' Collection

      - Roles

        - meta_template

        - meta_role

        - meta_playbook

        - meta_orchestrator

    - 'Network' Collection

      - Roles

        - network.openvswitch

          - Description: Manages the Installation and Configuration of the OpenVSwitch Software

        - network.network

          - Description: Entry point / Interface for interacting with the network collection. Delegates configurations containing the network subsystems to the other roles

          - Parameters: ...

          - 

        - network.ovs_bridge

# Tasks

  - Current Objectives

    - Collate All Tasks

      - Search

        - Current Repo

        - Github Wiki

        - Old 'orchestration-architect' system

          - OA

          - Legacy

    - Document Writing Styles per Document Type (Template/Skeleton)

      - Architectural Design Decisions

      - Tasks

  - Current Tasks

    1. Collecting Information / Working on Deliverables

      - Add Resource Type and Contents Slowly Here

        - GITHUB ISSUES

          - current repo

            - Unmigrated stuff
              > Migration
              > OA001 Provision
              > 
              > Being done as part of the OA999 Container standardisation and migration of OA001 Application and Services.
              > OA001 Applications and Services
              > 
              > Things to migrate: Groups, Permissions, PXE Server, Netboot ISO generation, Startup Plabooks, Update Playbook for OA001, User and SSH configuration, WIFI and Zram etc.
              > Collection: Configuration Playbooks
              > 
              > Bluetooth, Productivity, ZRam.
              > Collections: Desktop
              > 
              > roles:
              > dotfiles
              > desktop - contains template configurations for window managers
              > Collection: System MASSIVE UNDERTAKING
              > 
              > role: archiso
              > maybe later: use mkosi or debootstrap etc.
              > Collection : Hypervisr OA002
              > Collections: Packager/Builder...
              > 
              > Roles:
              >  don't forget to package my motd as an application
              > 
              >     package...
              >     package_dependency (go, pacman, git?)
              >     git?
              > 
              > Will make package be in charge of packaging..
              > These will be preceded with a repo to build from,
              > external projects will be added as subtrees to the 0.8.2-dev....
              > 
              > go_package
              > rust_package
              > arch_package
              > Role: storage.btrfs_subvolumes
              > 
              > Need to migrate snapshot and restore.
              > so set to checkpoint, and have a description (like configured base install)
              > and another state be restored. figure out the logic later based on the generation tree.
              > Collections: Containers
              > 
              > roles: lvm
              > Collection: Bootstrap
              > 
              > investigate the orchestrator_bootstrap role
              > Collection: System
              > ALSO BACKUP AND EMERGENCY ISO BOOT ON RECOVERY THAT IS ONLY SWAPPED AFTER A SUCCESSFUL BOOT OF THE NEW ISO.
              > NEED TO BE ABLE TO HAVE HOME USER DIRECTORIES SETUP SO THAT WRITES ARE PERSISTED AT PARTICULAR TIMES, WE CAPTURE THE CHANGES TO MAKE A MARK, OR PROVIDE NFS OR NBD VOLUMES.
              > Later Explore The Full Storage stack of btrfs, zram, bcachefs, and measure the perform.
              > Collection: Vault? (will i still use this)
              > 
              > roles: vault?
              > roles: datablock? (replaced by storage.loop_device that does the same thing)
              > Collection: Networking
              > 
              > Roles:
              > 
              >     sshfs
              >     nbd server
              >     nfs... etc.
              >     openvswitch
              >     ovs_bridge
              >     network, network_bridge??
              > 
              > Aftermath
              > 
              > Setup CI/CD pipeline, code review pipeline, setup proper git server, and openvswitch network with containered applications using it.
              > 
              > Working on a schema and abstract state machine / fractal finite state machine / through the embedding of lens in an open dynamic system using the klesi category to be able to embed the lens in the lens, etc. using a abstract state machine / push down automata, being built up creating a FSM that can define objects through finishing states and defining maps, and using functors to perform operations that evolve the FSM by modifying the (alphabet, set of states. the state x input transistions, etc) tuples. Just something I'm brain storming on paper.

            - Migrate 'Network' Collection
              > 
              > SuperPanda commented Aug 14, 2024
              > 1. Network Role Development
              > 
              > Objective:
              > Develop a comprehensive network role that includes Open vSwitch (openvswitch) and its associated bridges (ovs_bridge). This role will serve as the central point for network configurations within the Orchestration Architect framework.
              > 
              > Key Components:
              > 
              >     openvswitch: Manages the main Open vSwitch configurations, taking a list of openvswitch_bridges.
              >     ovs_bridge: Configures individual bridges within Open vSwitch, including ports, interfaces, VLAN IDs, and other related settings.
              > 
              > Tasks:
              > 
              >     Develop openvswitch Role:
              >         Create a present, absent, and info state for Open vSwitch.
              >         Define parameters for openvswitch_bridges, allowing dynamic configuration of multiple bridges.
              > 
              >     Develop ovs_bridge Role:
              >         Create present, absent, and info states for configuring OVS bridges.
              >         Ensure the role handles ports, interfaces, and VLAN configurations.
              > 
              >     Integrate with Network Role:
              >         Ensure the network role can dynamically call the openvswitch and ovs_bridge roles based on the provided specifications.
              > 
              > Requirements:
              > 
              >     Ensure compatibility with mTLS configurations.
              >     Support dynamic updates and changes to network configurations via Ansible playbooks.
              >     Document usage and provide examples in the network role README.
              > 
              > 2. OA001 System Recreation and Testing
              > 
              > Objective:
              > Recreate OA001 (System Master Control Node) with improved processes for managing subvolumes, ensuring that even with the same filesystem and partition name, subvolumes can be moved or replicated without issues.
              > 
              > Tasks:
              > 
              >     Rebuild OA001:
              >         Use the latest backups and specification files to reconstruct OA001.
              >         Implement a process for testing the movement of USB-based systems with consistent subvolume management.
              > 
              >     Develop Playbook for USB and Subvolume Management:
              >         Create a playbook that handles the movement of USB devices, ensuring subvolume consistency across different systems.
              >         Integrate device map handling to create predictable names for subvolumes and devices.
              > 
              > Requirements:
              > 
              >     Ensure seamless transition and consistency when moving USB devices between systems.
              >     Test with different filesystems and partition names to validate robustness.
              >     Provide detailed documentation for the process, including troubleshooting steps.
              > 
              > 3. CI/CD Pipeline and Playbook Execution in Containers
              > 
              > Objective:
              > Establish a CI/CD pipeline that efficiently runs playbooks within containers, leveraging tools like SSH and Open vSwitch for network configurations.
              > 
              > Tasks:
              > 
              >     CI/CD Pipeline Setup:
              >         Define a clear process for integrating playbook execution into a CI/CD pipeline.
              >         Use containers (via systemd-nspawn or Docker) to run playbooks in isolated environments.
              > 
              >     Containerized Playbook Execution:
              >         Develop roles or playbooks that set up containers with necessary tools (SSH, Open vSwitch) for running playbooks.
              >         Ensure containers are configured to support automated testing and deployment processes.
              > 
              >     Open vSwitch Integration:
              >         Integrate Open vSwitch into the CI/CD pipeline to manage container networking.
              >         Test mTLS-secured connections within the CI/CD environment.
              > 
              > Requirements:
              > 
              >     Ensure the pipeline is scalable and can handle multiple playbooks and roles concurrently.
              >     Automate the process to reduce manual intervention, including handling failures and retries.
              >     Document the CI/CD setup, including step-by-step guides for configuration and maintenance.
              > 
              > 4. GPG Key Management
              > 
              > Objective:
              > Set up a GPG key management system with a focus on long-term master keys and intermediate keys for daily operations.
              > 
              > Tasks:
              > 
              >     Develop GPG Key Role:
              >         Implement a gpg_key role that handles the creation, storage, and management of GPG keys.
              >         Ensure the role can differentiate between master and intermediate keys, with the master key designed to last indefinitely.
              > 
              >     Document Key Management Strategy:
              >         Write a README outlining the key management process, including scenarios for key loss, rekeying, and expiration.
              >         Provide examples for generating, storing, and using GPG keys within the Orchestration Architect framework.
              > 
              > Requirements:
              > 
              >     The master key should have no expiration, minimizing disruption in case of key loss.
              >     Intermediate keys should be rekeyed periodically or on-demand to enhance security.
              >     Ensure keys are stored securely, with the option to use air-gapped systems for sensitive operations.
              > 
              > 5. Finalization of nspawn and QEMU Runner Roles
              > 
              > Objective:
              > Finalize the nspawn_runner and qemu_runner roles, ensuring they are fully integrated into the parent container role and support the ephemeral execution.
              > 
              > Tasks:
              > 
              >     Complete Runner Roles:
              >         Finalize the implementation of present, absent, info, and rekey states for both nspawn_runner and qemu_runner.
              >         Ensure integration with storage and network roles for seamless container/VM creation and management.
              > 
              >     Create Example Playbooks:
              >         Develop playbooks that demonstrate the usage of nspawn_runner and qemu_runner, focusing on ephemeral container/VM execution.
              >         Include scenarios for snapshotting, rolling back, and dynamically configuring containers/VMs.
              > 
              > Requirements:
              > 
              >     Ensure that both runner roles support dynamic configuration based on input parameters.
              >     Integrate snapshot management for both nspawn and QEMU, allowing for quick rollbacks.
              >     Document the role usage, including configuration options and examples.
              > 
              > Additional Ideas for USB and Subvolume Management
              > 
              > Objective:
              > Develop a robust playbook to manage subvolumes on USB devices, ensuring consistency and predictability across different systems.
              > 
              > Tasks:
              > 
              >     Subvolume Naming and Management:
              >         Implement device map handling to create predictable names for subvolumes, even with the same filesystem and partition name.
              >         Develop a playbook to automate the movement of subvolumes between systems, ensuring they retain their integrity.
              > 
              >     Testing and Validation:
              >         Test the process across multiple systems, verifying that subvolumes can be moved without issues.
              >         Document any edge cases or challenges encountered during testing.
              > 
              > Requirements:
              > 
              >     Ensure that the playbook can handle various scenarios, including different filesystem types and partition configurations.
              >     Provide a clear process for troubleshooting and resolving subvolume-related issues.
              > 
              > Summary of All Tasks
              > 
              >     Develop Network Role with Open vSwitch Integration:
              >         Create openvswitch and ovs_bridge roles.
              >         Integrate into the broader network role.
              > 
              >     Recreate and Test OA001:
              >         Rebuild OA001 using the latest specifications.
              >         Develop a playbook for managing USB devices and subvolumes.
              > 
              >     Establish CI/CD Pipeline:
              >         Set up a container-based CI/CD pipeline for running playbooks.
              >         Integrate SSH and Open vSwitch into the pipeline.
              > 
              >     Implement GPG Key Management:
              >         Create a gpg_key role with master and intermediate key handling.
              >         Document key management processes.
              > 
              >     Finalize nspawn and QEMU Runner Roles:
              >         Complete and integrate runner roles.
              >         Develop example playbooks demonstrating their usage.
              > 
              >     Subvolume and USB Management:
              >         Develop a playbook for managing subvolumes across different systems.
              >         Test and document the process thoroughly.
              > 
              > Conclusion
              > 
              > This detailed task report and requirements list provide a clear roadmap for the next phases of the Orchestration Architect project. By addressing each of these tasks systematically, we can ensure that the framework is robust, scalable, and ready for future challenges. Let's proceed with the implementation, ensuring that each component is well-documented and thoroughly tested.

            - Containers with NSpawn and QEMU Runners
              > Orchestration Architect Framework: Runner and Container Role Specifications
              > Overview
              > 
              > We are tasked with designing, implementing, and refining the nspawn_runner and qemu_runner roles as part of the Orchestration Architect framework. These roles will be integrated into a parent container role that will manage the lifecycle of ephemeral containers and VMs, including storage management, snapshotting, and dynamic provisioning of applications.
              > 1. Role Specifications
              > Parent Container Role
              > 
              > Purpose:
              > The container role will serve as an overarching role that can take other roles such as storage and networking and configure containers dynamically based on the specified parameters.
              > 
              > Parameters:
              > 
              >     container_type: Specifies the type of container/VM (e.g., nspawn, qemu).
              >     container_name: Name of the container or VM instance.
              >     storage: Specifies storage parameters including volume pools, subvolumes, and ephemeral storage setups.
              >     network: Network configuration for the container, including options for mTLS or other secure networking methods.
              >     ssh_key: Public SSH key to be injected into the container for remote access.
              >     applications: List of applications to be installed and configured in the container on-demand.
              > 
              > States:
              > 
              >     present: Creates and configures the container, applying storage, network, and application configurations.
              >     absent: Removes the container and cleans up any associated resources.
              >     info: Provides details about the container's current state, configuration, and resource usage.
              > 
              > Tasks:
              > 
              >     Prepare Storage: Set up storage volumes using the storage role, ensuring that Btrfs subvolumes or loop devices are configured as needed.
              >     Configure Network: Apply network configurations, including setting up mTLS tunnels if required.
              >     Deploy Container: Instantiate the container (nspawn or QEMU) with the specified parameters.
              >     Install Applications: Install and configure applications in the container using dynamic playbooks.
              > 
              > nspawn_runner Role
              > 
              > Purpose:
              > The nspawn_runner role will manage the lifecycle of a systemd-nspawn container, including creating snapshots, ephemeral storage pools, and application configurations.
              > 
              > Parameters:
              > 
              >     image_path: Path to the base filesystem for the container.
              >     machine_name: Name of the systemd-nspawn container.
              >     boot_options: Boot options for the container.
              >     network: Network setup, including potential mTLS configurations.
              >     ephemeral: Boolean to determine if the container is ephemeral.
              >     storage_pool: Configuration for an ephemeral storage pool, potentially using a loop device and Btrfs.
              >     btrfs_pool: Specifies Btrfs subvolumes and their configuration.
              >     ssh_key: SSH public key to be injected for remote access.
              > 
              > States:
              > 
              >     present: Configures and starts the systemd-nspawn container.
              >     absent: Stops and removes the container, including any associated storage.
              >     info: Provides details about the current state and configuration of the container.
              >     rekey: Regenerates the SSH key or reconfigures the container's security settings.
              > 
              > Tasks:
              > 
              >     Prepare Storage: Create and mount ephemeral storage pools and Btrfs subvolumes.
              >     Deploy Container: Start the systemd-nspawn container with the specified configuration.
              >     Install Applications: Dynamically install applications based on the container\u2019s configuration.
              >     Snapshot Management: Create and manage snapshots of the container\u2019s base system.
              > 
              > qemu_runner Role
              > 
              > Purpose:
              > The qemu_runner role will manage the lifecycle of a QEMU virtual machine, focusing on ephemeral execution, boot options, and live USB prototype testing.
              > 
              > Parameters:
              > 
              >     drive: Path to the virtual disk image.
              >     cpu_count: Number of CPUs to allocate to the VM.
              >     memory_size: Amount of memory to allocate.
              >     network: Network configuration, including secure tunnels.
              >     boot_options: Additional boot options for QEMU.
              >     ssh_key: SSH public key for remote access to the VM.
              > 
              > States:
              > 
              >     present: Configures and starts the QEMU VM.
              >     absent: Stops and removes the VM.
              >     info: Provides information about the VM\u2019s current state.
              >     rekey: Regenerates or updates SSH keys and security settings.
              > 
              > Tasks:
              > 
              >     Prepare Disk: Ensure the virtual disk image is configured correctly.
              >     Deploy VM: Start the QEMU VM with the defined parameters.
              >     Install Applications: Install and configure applications within the VM.
              >     Snapshot Management: Handle snapshots and cloning of the VM for rapid prototyping.
              > 
              > 2. Design Rationale
              > Container Role and Runners
              > 
              >     Modularity and Flexibility: The design emphasizes modularity, allowing the container role to integrate different runners (nspawn, QEMU, etc.) based on the container_type parameter. This modular approach allows for different container types to be managed consistently under a single parent role.
              > 
              >     Ephemeral and Secure: Both runners are designed to operate ephemerally, ensuring that any changes made during the container or VM's execution do not persist after shutdown. This is crucial for testing and prototyping environments where you need to revert to a known state easily.
              > 
              >     Storage and Networking Integration: The roles integrate tightly with storage and networking components, allowing for sophisticated setups like mTLS-secured networks or Btrfs-based storage pools. This ensures that containers and VMs are both flexible and secure, capable of handling complex workloads and configurations.
              > 
              >     Snapshot and Rollback Capabilities: Both runners include snapshot management, allowing you to take and revert snapshots of the container or VM\u2019s state. This is especially useful in development environments where frequent changes are made, and you need the ability to roll back quickly.
              > 
              > 3. Clarification of States
              > 
              >     Present: This state is used to set up, configure, and start the container or VM. It involves preparing the environment, applying configurations, and ensuring the system is ready for use.
              > 
              >     Absent: This state is used to cleanly shut down and remove the container or VM and its associated resources. It ensures that no leftover artifacts remain after removal.
              > 
              >     Info: This state provides detailed information about the current configuration and status of the container or VM. It can be used for auditing, monitoring, or debugging purposes.
              > 
              >     Rekey: This state is specific to security and is used to update or regenerate keys and other security-related configurations within the container or VM.
              > 
              > 4. Immediate Tasks
              > 
              >     Finalize Runner Roles:
              >         Implement the present, absent, info, and rekey states for both the nspawn_runner and qemu_runner.
              >         Ensure integration with the parent container role, allowing dynamic configuration and instantiation.
              > 
              >     Build Playbooks:
              >         Create playbooks to deploy a fresh Arch Linux container using the nspawn_runner, including snapshotting the base system.
              >         Develop a playbook for ephemeral QEMU VM execution, focusing on live USB prototype testing.
              > 
              >     Migrate Configurations:
              >         Ensure all SSH configurations, sudoer settings, and PAM hardening policies are migrated to the new system.
              >         Validate that these configurations are applied correctly in both nspawn and QEMU environments.
              > 
              >     GPG Key Setup:
              >         Implement the GPG key management system with a master key that does not expire and an intermediate key for daily operations.
              >         Document the setup process and key management strategies, ensuring that all use cases (e.g., key rekeying, expiration) are clearly covered.
              > 
              > Conclusion
              > 
              > This detailed specification and rationale provide a clear roadmap for developing, testing, and deploying the nspawn_runner and qemu_runner roles within the Orchestration Architect framework. The emphasis is on modularity, security, and flexibility, ensuring that our system is robust and capable of handling complex configurations in a dynamic and ephemeral manner. Let's proceed with the implementation, keeping the goals and states in mind, and ensure that our documentation and execution align closely as we move forward.

        - WIKI

        - JULIA

        - OLD DOCUMENTS

        - PHYSICAL DOCUMENTS

        - Transcripts/Journals

          - API GPT Transcripts

          - CHATGPT Transcripts

        - Legacy Repository

          - Development Principles
            > Theoretical Framework
            > 
            >     Category Theory as a Guiding Principle:
            >         Objects: Define each Ansible role as an object, representing a specific state or configuration in your system.
            >         Morphisms (States): Consider each state (including info) as a morphism, a transformation or action. The info state acts as an identity morphism, reflecting the current state without altering it.
            >         Functors: View the transition from one role's output to another's input as functors, mapping between these categories. The info state helps in understanding the output (current state) of one functor before it's inputted into another.
            > 
            > Design Guidelines
            > 
            >     Consistency Across Roles:
            >         Ensure every role has an info state that performs a standard set of operations: gathering current configurations, checking the status, and providing insights into the role\u2019s effect on the system.
            >         This state should be able to collate data that can be used by other roles, acting as a foundational layer for more complex interactions.
            > 
            >     Information Gathering and Presentation:
            >         The info state should be comprehensive in its data collection, ensuring all relevant information about the role's current state is captured.
            >         The presentation of this information should be clear, concise, and structured in a way that is easily consumable by other roles and by system administrators.
            > 
            > Justification for Development Steps
            > 
            >     Enhanced Debugging and System Insights:
            >         By having a robust info state, you simplify the process of debugging and understanding the system's current configuration. This is crucial for complex orchestrations where interdependencies are significant.
            >         This approach aligns with self-documenting practices, making the system more maintainable and understandable.
            > 
            >     Foundation for Future Extensions:
            >         Establishing a well-defined info state sets the groundwork for future expansions and integrations. Knowing the precise state of each component allows for safer and more predictable modifications and enhancements.
            > 
            >     Streamlined Development Process:
            >         With a clear theoretical and practical guideline, developers can easily understand their role in the project and how their contributions fit into the larger picture. This reduces the learning curve and accelerates the development process.
            > 
            > Next Steps in Development
            > 
            >     Implement and Refine info States: Begin by implementing or refining the info state in each role, focusing on data collection and presentation.
            > 
            >     Integration Testing: Test how the info state from one role integrates with other roles. For example, how does the info output of the luks role influence the behavior of the btrfs_subvolumes role?
            > 
            >     Documentation and Examples: Document each role\u2019s info state comprehensively, including examples of its output and how this output can be utilized by other roles or for system insights.
            > 
            >     Feedback Loop: Create a feedback mechanism for each implementation of the info state. This could be in the form of automated tests or peer reviews to ensure the output is consistent with the design principles.
            > 

          - Notes
            > Orchestration Architect Ansible: A Category Theory Approach
            > Overview
            > 
            > Orchestration Architect Ansible integrates Infrastructure as Code (IaC) with applied category theory to create a robust and scalable system for managing complex IT infrastructure. This innovative approach uses the high-level abstractions of category theory to simplify and elucidate the relationships and transformations within system configurations.
            > Applying Category Theory to System Design
            > Category Theory Principles
            > 
            > The project employs key concepts from category theory to structure and manage system configurations:
            > 
            >     Objects: In our context, these represent distinct system states or configurations. For example, a storage device can have different states like 'encrypted' or 'unencrypted', 'mounted' or 'unmounted'.
            > 
            >     Morphisms: These are the transformations or actions that transition objects from one state to another. In Ansible, these are represented by tasks. For instance, encrypting a disk or mounting a filesystem are morphisms.
            > 
            >     Functors: They describe how one category (or system state) is mapped to another, preserving the structure of morphisms. For Ansible, this could be a role that translates a basic storage device into an encrypted LUKS device, maintaining its functional relationships.
            > 
            >     Natural Transformations: These articulate the interactions between functors, providing a higher-order view of how system changes affect each other. For example, changing the encryption method on a disk (a functor) might impact how it is mounted or accessed (another functor).
            > 
            > Design Philosophy
            > 
            >     Modularity and Composability: By treating system states and transitions categorically, we achieve a design where components (roles, tasks) can be easily composed and reconfigured without losing coherence.
            > 
            >     Predictability and Idempotency: The category theory approach helps in making system behavior predictable. Idempotency is a key focus, ensuring that repeated applications of the same configuration lead to the same state, a fundamental principle in IaC.
            > 
            >     Standardized Interfaces: Roles and tasks are designed to have standardized inputs and outputs, akin to morphisms in a category. This ensures that different components of the system can interact seamlessly.
            > 
            > Practical Applications
            > 
            >     Storage Management: Through category theory, the complexities of managing various storage states (like raw, encrypted, mounted) are abstracted into composable units, simplifying the configuration and management process.
            > 
            >     Network Configuration: The relationships between network components are modeled to ensure efficient and error-free configurations, essential for complex network setups.
            > 
            >     Virtualization and OS Provisioning: The approach allows for flexible and dynamic creation of virtual machines and operating systems, aligning with the high-level abstractions of category theory.
            > 
            > Conclusion
            > 
            > By applying category theory to IaC using Ansible, Orchestration Architect Ansible provides a unique and powerful way to manage complex IT infrastructure. It offers a theoretically sound framework that enhances understanding, scalability, and reliability of system configurations, making it an ideal project for those interested in the cutting-edge intersection of mathematics, system architecture, and software engineering.
            > LUKS Configuration Variables:
            > 
            >     luks_device_name: The name of the LUKS device (e.g., /dev/sda1).
            >     luks_key_file: The path to a file containing the LUKS key (optional, depending on your setup).
            >     luks_keyphrase: The passphrase for unlocking the LUKS device.
            >     luks_cipher: The encryption cipher to use for LUKS.
            >     luks_key_size: The size of the encryption key in bits.
            >     luks_hash: The hash function used for key derivation in LUKS.
            > 
            > Btrfs Configuration Variables:
            > 
            >     btrfs_volume_name: The name of the Btrfs volume.
            >     btrfs_mount_path: The path where the Btrfs volume is mounted.
            >     btrfs_subvolume_list: A list of subvolumes to create within the Btrfs volume.
            >     btrfs_subvolume_mount_path: The mount path for each Btrfs subvolume.
            > 
            > Mount Configuration Variables:
            > 
            >     mount_point: The path where the file system is mounted.
            >     fstype: The file system type (e.g., ext4, btrfs, etc.).
            >     options: Mount options for the file system (e.g., defaults, noatime, etc.).
            >     state: The desired state of the mount (mounted, absent, etc.).
            > 
            > luks_config:
            >   luks_device_name: "/dev/sda1"
            >   luks_keyphrase: "your_passphrase"
            >   luks_cipher: "aes-xts-plain64"
            >   luks_key_size: 512
            >   luks_hash: "sha256"
            > 
            > btrfs_config:
            >   btrfs_volume_name: "my_btrfs_volume"
            >   btrfs_mount_path: "/mnt/btrfs"
            >   btrfs_subvolume_list:
            >     - name: "subvol1"
            >       mount_path: "/mnt/btrfs/subvol1"
            >     - name: "subvol2"
            >       mount_path: "/mnt/btrfs/subvol2"
            > 
            > mount_config:
            >   mount_point: "/mnt/storage"
            >   fstype: "btrfs"
            >   options: "defaults"
            >   state: "mounted"
            > 
            > Certainly! Let's provide a comprehensive report that outlines the purpose, analysis of morphisms, configurations, and examples for the luks_role, btrfs_role, btrfs_subvolume_role, and mount_role in the context of managing storage configurations.
            > 1. luks_role
            > Purpose:
            > 
            > The luks_role is designed to manage LUKS (Linux Unified Key Setup) encryption for block devices. It ensures the existence of a LUKS-encrypted device, opens or closes the device, and sets specific LUKS configuration parameters.
            > Configuration Object:
            > 
            > luks_config:
            >   luks_device_name: "/dev/sda1"
            >   luks_keyphrase: "your_passphrase"
            >   luks_cipher: "aes-xts-plain64"
            >   luks_key_size: 512
            >   luks_hash: "sha256"
            > 
            > Morphisms (Tasks):
            > 
            >     Ensure LUKS Device Exists:
            >         Morphism: community.crypto.luks_device
            >         Purpose: Checks if the LUKS device exists and creates it if not.
            > 
            >     Open LUKS Device:
            >         Morphism: community.crypto.luks_device
            >         Purpose: Opens the LUKS device using the provided keyphrase.
            > 
            >     Set LUKS Cipher, Key Size, and Hash:
            >         Morphism: community.crypto.luks_device
            >         Purpose: Modifies the LUKS settings for cipher, key size, and hash.
            > 
            > Example Morphism Invocation:
            > 
            > - name: Ensure LUKS Device Exists
            >   community.crypto.luks_device:
            >     name: "{{ luks_config.luks_device_name }}"
            >     passphrase: "{{ luks_config.luks_keyphrase }}"
            >     cipher: "{{ luks_config.luks_cipher }}"
            >     key_size: "{{ luks_config.luks_key_size }}"
            >     hash: "{{ luks_config.luks_hash }}"
            >     state: present
            > 
            > - name: Open LUKS Device
            >   community.crypto.luks_device:
            >     name: "{{ luks_config.luks_device_name }}"
            >     passphrase: "{{ luks_config.luks_keyphrase }}"
            >     state: opened
            > 
            > 2. btrfs_role
            > Purpose:
            > 
            > The btrfs_role manages the creation of a Btrfs volume and the corresponding Btrfs subvolumes.
            > Configuration Object:
            > 
            > btrfs_config:
            >   btrfs_volume_name: "my_btrfs_volume"
            >   btrfs_mount_path: "/mnt/btrfs"
            >   btrfs_subvolume_list:
            >     - name: "subvol1"
            >       mount_path: "/mnt/btrfs/subvol1"
            >     - name: "subvol2"
            >       mount_path: "/mnt/btrfs/subvol2"
            > 
            > Morphisms (Tasks):
            > 
            >     Ensure Btrfs Volume Exists:
            >         Morphism: community.general.btrfs_device
            >         Purpose: Checks if the Btrfs volume exists and creates it if not.
            > 
            >     Create Btrfs Subvolumes:
            >         Morphism: community.general.btrfs_subvolume
            >         Purpose: Creates Btrfs subvolumes based on the provided list.
            > 
            > Example Morphism Invocation:
            > 
            > - name: Ensure Btrfs Volume Exists
            >   community.general.btrfs_device:
            >     name: "{{ btrfs_config.btrfs_volume_name }}"
            > 
            > - name: Create Btrfs Subvolumes
            >   community.general.btrfs_subvolume:
            >     name: "{{ item.name }}"
            >     mount_path: "{{ item.mount_path }}"
            >     state: present
            >   loop: "{{ btrfs_config.btrfs_subvolume_list }}"
            > 
            > 3. btrfs_subvolume_role
            > Purpose:
            > 
            > The btrfs_subvolume_role is responsible for managing individual Btrfs subvolumes.
            > Configuration Object:
            > 
            > btrfs_subvolume_config:
            >   subvolume_name: "my_subvolume"
            >   subvolume_mount_path: "/mnt/btrfs/my_subvolume"
            > 
            > Morphisms (Tasks):
            > 
            >     Ensure Btrfs Subvolume Exists:
            >         Morphism: community.general.btrfs_subvolume
            >         Purpose: Checks if the Btrfs subvolume exists and creates it if not.
            > 
            > Example Morphism Invocation:
            > 
            > - name: Ensure Btrfs Subvolume Exists
            >   community.general.btrfs_subvolume:
            >     name: "{{ btrfs_subvolume_config.subvolume_name }}"
            >     mount_path: "{{ btrfs_subvolume_config.subvolume_mount_path }}"
            >     state: present
            > 
            > 4. mount_role
            > Purpose:
            > 
            > The mount_role handles the mounting of file systems, including Btrfs volumes.
            > Configuration Object:
            > 
            > mount_config:
            >   mount_point: "/mnt/storage"
            >   fstype: "btrfs"
            >   options: "defaults"
            >   state: "mounted"
            > 
            > Morphisms (Tasks):
            > 
            >     Ensure Mount Point Exists:
            >         Morphism: community.general.file
            >         Purpose: Checks if the mount point directory exists and creates it if not.
            > 
            >     Mount File System:
            >         Morphism: community.general.mount
            >         Purpose: Mounts the file system at the specified mount point.
            > 
            > Example Morphism Invocation:
            > 
            > - name: Ensure Mount Point Exists
            >   community.general.file:
            >     path: "{{ mount_config.mount_point }}"
            >     state: directory
            > 
            > - name: Mount File System
            >   community.general.mount:
            >     path: "{{ mount_config.mount_point }}"
            >     src: "/dev/{{ btrfs_config.btrfs_volume_name }}"
            >     fstype: "{{ mount_config.fstype }}"
            >     opts: "{{ mount_config.options }}"
            >     state: "{{ mount_config.state }}"

          - Readme
            > Orchestration Architect Ansible
            > Overview
            > 
            > Orchestration Architect Ansible is an experimental project aimed at managing complex systems through Infrastructure as Code (IaC) principles. This project distinctively incorporates applied category theory to structure and manage Ansible roles, aiming to create a system orchestration framework that is robust, scalable, and logically structured.
            > 
            > Key Features of the Project:
            > 
            >     Ansible Integration: Uses Ansible for system management and orchestration, focusing on the composition of interacting components.
            >     Modular Design: The project is structured for modularity, with easy configuration adjustments made possible through variable files.
            >     Roles and Responsibilities: Includes roles for bootstrapping, LUKS key management, storage pool handling, KVM environment provisioning, network configuration, and the generation of custom bootable Linux distributions.
            >     Encrypted Block Storage: Manages encrypted block storage with features for snapshotting and rollback, enhancing data security.
            >     Arch Linux OS Build Pipeline: Incorporates a customizable Arch Linux OS build pipeline for in-memory operations.
            >     Virtual Machine Management: Features a suite for managing virtual machines, complete with live system emulation under KVM.
            >     Software-Defined Networking: Supports a software-defined networking infrastructure, facilitating robust CI/CD pipelines.
            >     Additional Tools: Offers an OS Builder, PXE Server, network, and memory overlay file systems, and a network manager.
            > 
            > The project is focused on transparency in infrastructure management, emphasizing practices that are self-documenting to ensure clarity and ease of maintenance. It's designed to facilitate the exploration of different configurations, and technical users who require a system that allows them to design, manage, and deploy infrastructure from text files, enabling them to test changes in a virtualized environment before deploying them to production. Or to bench mark different configurations. Orchestration Architect Ansible is a learning/experimental project designed to manage complex systems through Infrastructure as Code (IaC) principles. This project uniquely employs applied category theory to structure and manage Ansible roles, creating a robust, scalable, and understandable system orchestration framework.
            > 
            > This project leverages Ansible to manage and orchestrate systems through the composition of interacting components. It includes roles for orchestrating the bootstrap process, managing LUKS keys, handling storage pools, provisioning KVM environments, configuring networks, and generating custom bootable Linux files. The project structure is designed for modularity, allowing easy configuration through variable files. This project illustrates managing complex systems using Infrastructure as Code (IaC), extending its capabilities to include the creation, administration, and testing of encrypted block storage with snapshot and rollback features. It encompasses a customizable in-memory Arch Linux OS build pipeline and a comprehensive suite for virtual machine management. The system supports live system emulation under KVM, complete with a software-defined networking infrastructure, facilitating robust CI/CD pipelines. Additionally, it features an OS Builder, a PXE Server, network and memory overlay file systems, and a network manager. The infrastructure is managed in a way that's transparent to organizations, emphasizing self-documenting practices for clarity and ease of maintenance.
            > 
            > In other words, you can use it to design, manage, and have redeployable infrastructure from a text file, and have multiple environments where production using bare metal systems on a physical network can be changed, tested in a hypervisor with software defined network, then deployed after validation.
            > Theoretical Underpinnings
            > 
            > The project adopts concepts from category theory to structure and manage configurations, leading to a system that is both logically sound and practically efficient. Key principles include:
            > Objects and Morphisms
            > 
            >     Objects: Representing system states, such as a locked/unlocked LUKS device or a mounted/unmounted BTRFS filesystem. In our context, objects is the desired configuration. A task file will be named as a desired configuration (roles/tasks/unlocked.yml).
            >     Morphisms: Morphisms are the steps to achieve a configuration, facilitating transitions between different states of an object. For instance, a morphism might be the transition of a storage volume from unencrypted to encrypted (LUKS) or manage the lifecycle of a BTRFS subvolume.
            >     Functors: These map objects and morphisms from one context (category) to another, providing a powerful way to abstract complex operations. For instance, mapping a storage path to a LUKS-encrypted path if the LUKS role is active.
            >     Natural Transformations: Demonstrated in the interactions between roles. For example, how the state of a LUKS container (locked/unlocked) affects the accessibility of a BTRFS subvolume. These represent interactions between functors, such as the impact of unlocking a LUKS volume on the accessibility of a BTRFS filesystem.
            > 
            > Composability and Idempotency
            > 
            >     Composability: Our roles are designed to be composed together in a sequence, allowing for complex configurations to be built from simpler, reusable components.
            >     Idempotency: A key feature in Ansible and our design, ensuring that roles and tasks can be run multiple times without changing the outcome beyond the initial application.
            > 
            > Design Decisions
            > 
            >     Fail fast: We want to provide assertions for expected parameters, be overly strict with assertions, then reduce if needed. Rather something not work, then work in unexpected ways.
            >     Routing via main.yml: Each role's main.yml acts as a router, directing Ansible to the appropriate task files based on the state of the system. This routing mechanism ensures modularity and clear state management.
            >     Standardized Data Formatting: The roles are designed to format and pass data consistently, ensuring that each state transition receives the context needed for accurate execution.
            >     Info State: Utilized to gather and display the system's current configuration and state, based on the configuration parameters provided to a role. It provides valuable starting point for developing new roles, as the info state is routed through the main.yml task which will structure the data, meaning other states will have a predictable interface by means of getting the info state to work first, and also allows to see configurations that might have been missed. Other common states are: 'present', 'absent', ...
            > 
            > Usage (ehh.. not ready yet)
            > 
            >     Clone the repository.
            >     (Optional) Run ./setup-tmux.zsh for development environment
            >     Run ./setup-ansible.sh
            > 
            > Getting Started
            > Clone the Repository:
            > 
            > git clone https://github.com/SuperPanda/orchestration-architect-ansible.git
            > cd orchestration-architect-ansible
            > 
            > Configure Bootstrap Variables:
            > 
            > Update vars/bootstrap_vars.yml with relevant configuration for orchestration.
            > Project Structure
            > 
            > project_root/
            > \u2502
            > \u251c\u2500\u2500 playbooks/
            > \u2502   \u2514\u2500\u2500 ... (list of playbooks)
            > \u2502
            > \u251c\u2500\u2500 roles/
            > \u2502   \u2514\u2500\u2500 ... (list of roles)
            > \u2502
            > \u251c\u2500\u2500 vars/
            > \u2502   \u2514\u2500\u2500 ... (list of variable files, definition of networks, or reusable compositions)
            > \u2502
            > \u251c\u2500\u2500 templates/
            > \u2502   \u2514\u2500\u2500 ... (list of template files)
            > \u2502
            > \u2514\u2500\u2500 vault/
            >     \u2514\u2500\u2500 ... (list of vault files)
            > 
            > Roles
            > 
            >     Storage Role: Manages different storage configurations, providing a unified interface for filesystem and encrypted volume management.
            >     LUKS Role: Handles encrypted volumes, with tasks representing morphisms for encryption-related actions.
            >     BTRFS Subvolumes Role: Manages BTRFS filesystems, showcasing the application of category theory in filesystem management.
            >     Network Roles: Sets up network configurations using Open vSwitch, allowing for sophisticated network setups.
            >     KVM Role: Facilitates virtual machine management using libvirt, with integration into Open vSwitch networks.
            >     Archiso Role: Designed for creating custom Arch Linux ISOs for various purposes, including PXE boot environments, live systems, usb.
            > 
            > Task Routing and Data Formatting
            > 
            >     Main.yml Routing: Acts as a router directing to specific task files based on the state, demonstrating functorial behavior in task execution.
            >     Standardized Data Format: Ensures consistency and predictability in the way data is passed and processed across different roles.
            > 
            > Short-Term Objectives
            > 
            >     Refine Storage, LUKS, and BTRFS Roles: Enhance these roles to ensure seamless integration.
            >     Migrate Features from 00_enc_blkdev Role: Transition features to the new roles following the updated design principles.
            >     Network and KVM Role Development: Implement and align network roles for advanced configurations and integrate the KVM role for VM management.
            >     Archiso Role Alignment: Align the Archiso role with the project's design philosophy, enabling the creation of custom OS images for various use cases, including PXE booting. Package cache configurations.
            >     Bootstrapping v0.1: Finalize the project's foundation, leading to the first significant release.
            >     Network and KVM Integration: Align these roles to follow design principles
            >     Archiso Role: Align the Archiso role with category theory principles for custom OS image creation. Allowing to experiment with different configurations, and build nvim, zsh configurations, etc.
            > 
            > Next Steps
            > 
            >     Support for Raspberry Pi Images: Extend the project to support Raspberry Pi devices because the video out is busted and being to pxeboot an image with ssh configured would be useful
            >     PXE Boot Environment: Develop a PXE boot environment for automated provisioning of custom OS images.
            >     Live System Migration: Allow running systems to migrate between two environments live
            >     Efficient Package Management: Implement package caching for Arch Linux to optimize resource usage.
            >     Proper CI/CD pipeline: Implement CI/CD pipeline, add tests.
            > 
            > Contributing
            > 
            > We welcome contributions from those interested in Ansible, system orchestration, and applied category theory. This project is not only a practical orchestration tool but also a learning platform for these emerging and intersecting fields.
            > System Design Considerations
            > Flexibility and Extensibility
            > 
            > The project prioritizes flexibility and extensibility to accommodate diverse infrastructure requirements. Each role is modular, allowing users to adapt and expand functionality as needed.
            > Security
            > Security is a core consideration, especially in roles like enc_blkdev_provision and luks_key_management. The project aims to ensure the secure management of encrypted data and encryption keys.

    2. Document the OA001 System Design and Usage

    3. Figuring out where to put everything, and how I want to work on this

      - Manual

        - Collections

        - Architectural Design Decisions

        - Tasks - Roadmap, Changelog

        - Designs

        - Configuration

        - Requirements

  - Future Objectives

    - Setup Resume and CV stuff online

    - Make services available online again

    - Document this project publically

      - Manual on Github

    - Get my old systems back up and running.

      - Setup USB

      - 

    - Get other systems to use this.

# Designs

  - The 'OA' Systems Series

  - Configuration System

  - Template System: Designing for human-machine shared authorship.

# Repository

  - Repo: /srv/git/orchestration-architect.git 

    - Architectural Design Decision: Evolving Codebase

      - The 'Seed -> Pristine -> Dev' Adjunctive Cycle

        - Seed bootstraps Pristine

        - Code Lifecycle Diagram

          - <img src="images/img000001.svg" alt="image" width="832" height="219"/><br/>
            

        - Dev always rebases on update pristine

        - Seed is unique code up to isomorphism from Dev

      - The 'initial' branch (object)

        - All branches should share an initial object ancestor.

        - Enables simple rebase and integration; and improves maintainability when working when branches

          - Initial objects of empty branches as the tip of the tree allows for emergent universal properties that facilitate the replaying and ensuring uniqueness up to isomorphism due to the (co)limits axiomatic definitions being present (when initial objects are used) 

      - Notes

        - The Seed structures and self-versioning based on compatibilities and known limits and colimits allows for seeds to be shared, and the functionality will be implemented by running the bootstrap process for the target repository.

        - Repository is unique to the user, and is self contained (works in air gapped environments)

    - Branches (version 0.8)
      > Branch	                    Description
      > pre_release-splash	Landing Page
      > 0.8.0-sandbox	        Space to try out things
      > 0.8.0-initial               	Initial Object of Branches
      > 0.8.0-seed                  	Compact Self-Bootstrap
      > 0.8.0-pristine	            Post-Bootstrap
      > 0.8.0-dev                   	Development occurs here
      > 0.8.0-documents	    Source af documents generation
      > 0.8.0-assets	                Assets used in wallpapers, etc
      > 0.8.0-tools                 	Holds scripts for the user
      > 0.8.0-tests	                Holds unit/integration tests

      - Work Tree Layout

        - Configuration

          - /etc/orchestration-architect/vars

          - /usr/share/orchestration-architect/vars

        - Development

          - Seed

          - Pristine

          - Develop

        - Build

        - Release

      - Packaged Releases

        - Collections

          - /usr/share/orchestration-architect/collections/

        - Tools

          - /usr/bin/orchestration-architect/

            - Should check if works

          - /usr/bin/local/orchestration-architect/tools/

        - Git

          - Origin: /srv/git/orchestration-architect.git

          - Mirror: SuperPanda/orchestration-architect.git

# Documentation

  - Designs/Features

    - Theory

      - Abstract Compositional Topology:  Building Axioms for Universal Design Constructs

      - Security and Reliability in a World of Chaos: Self-Bootstrapping, Self-Healing, Regenerative Structures; or How I came to Love Universal Construction in an Ephemeral World

      - Generating Multiplicative Components for Emergent Design in Systems: Boundless Functionality in Bounded Complexity

  - Task-Adjacent

    - Tasks automatically move between documents

      - Changelog (Completed)

      - Roadmap (Backlog and Current)

  - Architecture

  - Reference

    - Collections

  - User Guide

    1. Install Master Configuration and Provisioning System

      - Encrypted Transient Master System Controller Persistent LiveUSB

        - (Recommended) As it allows for generation of master keys and is used for recovery, restoration, and rebuilding

        - (Alternatively)

          - Ephemeral Sandbox

          - File-backed Virtual Machine

    2. Build and Deploy Ephemeral In-memory Security Hardened Nested Hypervisor

      - (Recommended) Install via PXE Boot

      - TPM-secured Immutable Root FS booting

    3. Configure Personalised System Builds

      - Runtime Environment: NSpawn, Virtual Machine, Bare Metal

      - Natural Transformation

      - Higher-Order Composition

        - Make Higher-Order Systems through the Composition of Composed Systems

