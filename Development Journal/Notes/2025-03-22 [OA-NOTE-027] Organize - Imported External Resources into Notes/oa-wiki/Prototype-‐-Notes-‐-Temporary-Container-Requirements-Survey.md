
## Documentation for Temporary Container Experiment Playbook

### Overview
- **Playbook Name:** Temporary Container Experiment
- **Version:** 0.8.1
- **Description:**
This playbook establishes an ephemeral storage environment using `device mapper` and `btrfs` subvolumes to manage systemd-nspawn containers. The playbook also ensures idempotency and deterministic naming conventions for loop devices, and generates the `loop_device.target` file to store the `btrfs subvolumes` used to hold the `volume pool` btrfs subvolumes, which refer the pool of storage to be used inside another system. `Storage Pool` refers the host or builder, the `Volume Pool` refers to the target system or guest container

### Usage
This playbook can be executed with these overridable values when running `ansible-playbook playbooks/Sandbox/Temporary_Container_Experiment.yml ...`
```
-e [container_name=<CONTAINER_NAME>][,container_collection=<COLLECTION_NAME>][,ephemeral_base_path=<EPHEMERAL_BASE_PATH>]'
```
### Scope
The playbook broadens the category to instantiate device mapper-based storage setups, ensuring idempotent naming for loop devices.

### Requirements
1. **Setup Storage Pool Target**: Configure with the Storage role.
2. **Setup Volume Pool**: This includes targeting a block device image through a loop device, which is specified by the `storage_loop_device_target` variable. Here’s an example configuration:
   ```yaml
   role:
     name: storage
     storage:
       loop_device:
         name: <LOOP_DEVICE_NAME>
         target: <LOOP_DEVICE_TARGET>
   ```
3. **Create a role `orchestration_architect.Storage.loop_device`:**
   ```yaml
   `*<LOOP_DEVICE_STATE>*`: present | absent | info | offline | online
   ```
4. **Ensure Storage Role Specifics**: Add functor details to the `loop_device` role.
5. **Deploy**: Mount a `btrfs` subvolume in the ephemeral storage pool within `tmpfs` using `nspawn`.
6. **Utilize `copy-on-write` Mechanisms**: Design composable overlays with `btrfs_subvolumes`.

### Playbook Steps

#### Pre-run Playbooks
Import a pre-run playbook to set up the environment:
```yaml
- ansible.builtin.import_playbook: "../Meta/Setup_Environment"
```

#### Task Details

1. **Prepare Var Assignments**: Define key variables to be overridden if necessary.
   ```yaml
   vars:
     container_collection: "Sandbox"
     container_name: "Container_ALPHA"
     ephemeral_base_path: "/mnt/orchestration_architect/ephemeral"
     ephemeral_storage_pool: "{{ ephemeral_base_path }}/{{ container_collection }}/storage_pool"
     ephemeral_storage_pool_size: 4G
     container_base_size: 2G
   ```

2. **Create Ephemeral Storage Pool for Containers**:
   - Create mount point for ephemeral storage pool.
   ```yaml
   - name: Create Ephemeral Storage Pool for Containers
     include_role:
       name: storage
     vars:
       storage_mount_table:
         - source: tmpfs
           type: tmpfs
           options: "size={{ ephemeral_storage_pool_size }}"
           target: "{{ ephemeral_storage_pool }}"
           state: "mounted"
   ```

3. **Create Volume Storage**:
   - Directory creation for mount point and volume pool.
   - File creation for block device image.
   - Loop device setup.
   - `btrfs` filesystem configuration and subvolume creation.
   ```yaml
   - name: Create Volume Storage
     tasks:
       - name: Create Ephemeral Storage Pool mount point
         ansible.builtin.file:
           path: "{{ ephemeral_mount_point }}"
           state: directory
           mode: '0700'
       - name: Create Ephemeral Storage Pool
         ansible.builtin.mount:
           path: "{{ ephemeral_mount_point }}"
           src: "tmpfs"
           fstype: "tmpfs"
           opts: "size={{ ephemeral_storage_pool_size }}"
           state: "mounted"
       - name: Create container volume pool mount point directory
         ansible.builtin.file:
           path: "{{ container_volume_pool_mount_point }}"
           state: directory
           mode: '0700'
           - name: Create file for volume collection block device image
         community.general.filesize:
           path: "{{ container_volume_pool_block_device_image }}"
           size: "{{ container_base_size }}"
       - name: Create loop device to expose the volume pool
         command: "losetup --find --nooverlap --show {{ container_volume_pool_block_device_image }}"
         register: loop_device_result
       - name: Generate Container Volumes
         ansible.builtin.include_role: "storage"
         vars:
           storage_loopback_device:
             name: "{{ oollection_name }}"
       - name: Create BTRFS filesystem on the loop device
         filesystem:
           path: "{{ loop_device_result.stdout }}"
           type: btrfs
           opts: "-n 16k"
       - name: Create BTRFS subvolume for @init
         command: btrfs subvolume create {{ container_volume_pool }}/@init
       - name: Create @base subvolume
         command: btrfs subvolume snapshot -r {{ container_volume_pool }}/@init {{ container_volume_pool }}/@base
       - name: Create @overlay subvolume for changes
         command: btrfs subvolume create {{ container_volume_pool }}/@overlay
   ```

4. **Overlay and Initial Snapshot Configuration**:
   - Directory configurations for overlay.
   - Initial snapshot creation.
   ```yaml
   - name: Create overlay directories for nspawn
     ansible.builtin.file:
       path: "{{ ephemeral_storage_pool }}/overlay"
       state: directory
       mode: '0700'
   - name: Create initial snapshot for container
     command: btrfs subvolume snapshot {{ ephemeral_storage_pool }}/@base {{ ephemeral_storage_pool }}/@initial
   ```

5. **Systemd-nspawn Container Setup**:
   - Configuration and start of the systemd-nspawn container.
   ```yaml
   - name: Configure systemd-nspawn container
     community.general.systemd_nspawn:
       name: arch_container
       image: "{{ container_volume_pool }}/@base"
       machine: "arch_sandbox_container"
       command: /bin/zsh
       state: started
       boot: false
   ```

### System Managed Regions 
- **01_File_Header**
  This region is identified by the first `---` marker matches the regex expression '^---$'
- **02_Managed_Region_Before_Content**
  Managed block for pre-run steps. See `meta_playbooks` specification for more details.
- **04_Managed_Region_After_Content**
  Managed block for post-run steps (currently empty).

