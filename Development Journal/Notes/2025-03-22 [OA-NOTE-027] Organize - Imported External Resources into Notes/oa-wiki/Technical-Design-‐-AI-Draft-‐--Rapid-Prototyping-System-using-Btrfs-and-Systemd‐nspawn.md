# Technical Report: Rapid Prototyping System using Btrfs and Systemd-nspawn

## Introduction

The purpose of this technical report is to outline the architecture, strategies, and implementation details for a rapid prototyping system that leverages btrfs, systemd-nspawn, and overlay filesystems. The system aims to improve space efficiency, facilitate easy reconfiguration, and solve partial upgrade problems in a composable and resilient manner.

## System Architecture

### Btrfs Filesystem Setup

1. **Subvolumes:**
   - `@init`: An empty subvolume used as a template.
   - `@base`: Contains the root filesystem.
   - `@overlay`: Contains overlay configurations for testing various applications and system features.

2. **Loop Device:**
   - The btrfs filesystem is mounted as a loop device from a file residing on tmpfs, to leverage the benefits of RAM (speed and volatility for rapid prototyping).

### Systemd-nspawn Containers

- **Base Container:**
  - Utilizes `@base` for the root filesystem.
  - Provides a clean, up-to-date environment that other overlays can be tested against.
  
- **Overlay Containers:**
  - Use `@overlay` subvolumes that contain specific configurations and applications for testing purposes.

### Space Efficiency and Reflink Copy

Using the `cp --reflink` command, we can create space-efficient copies of the subvolumes, which allows for rapid reconstruction and reconfiguration without consuming additional disk space.

## Implementation Details

### Setting up Btrfs Subvolumes

```bash
# Create btrfs subvolume
btrfs subvolume create /mnt/mybtrfs/@init
btrfs subvolume create /mnt/mybtrfs/@base
btrfs subvolume create /mnt/mybtrfs/@overlay

# Mount btrfs subvolumes using systemd-nspawn
systemd-nspawn --directory=/mnt/mybtrfs/@base

# Use reflink to create space-efficient copies
cp --reflink=always /mnt/mybtrfs/@base /mnt/mybtrfs/@overlay/base01
```

### Supporting Multiple Overlays

The flexibility of btrfs and overlayfs allows for the combination of different subvolumes, enabling a composable configuration.

```bash
# Create overlayfs mount
mount -t overlay overlay -o lowerdir=/mnt/mybtrfs/@base,upperdir=/mnt/mybtrfs/@overlay/base01,workdir=/mnt/mybtrfs/@workdir /mnt/overlayfs_root
```

### OverlayFS for Layered Configuration

OverlayFS allows us to layer subvolumes, creating a union of multiple directories:

```sh
mount -t overlay overlay -o lowerdir=/mnt/btrfs/@base,upperdir=/mnt/btrfs/@overlay,workdir=/mnt/btrfs/work /mnt/overlay
```

This setup allows the overlay subvolume to compose over the base, providing a testing ground for new features without altering the base.

### Example Ansible Playbook for Overlay Configuration

```yaml
---
- name: Apply configuration to @overlay
  hosts: localhost
  tasks:
    - name: Ensure package is installed
      pacman:
        name: "{{ item }}"
        state: present
      with_items:
        - nginx
        - postgresql

    - name: Configure nginx
      copy:
        src: nginx.conf
        dest: /mnt/overlayfs_root/etc/nginx/nginx.conf
```

### Updating the @base and Reflink Copies

To address partial upgrade issues, the @base subvolume is updated periodically. New updates are applied to @overlay by creating a fresh reflink copy of @base.

```bash
# Update @base
pacman -Syu --root /mnt/mybtrfs/@base

# Create new reflinked overlay
cp --reflink=always /mnt/mybtrfs/@base /mnt/mybtrfs/@overlay/base02

# Apply playbooks to new overlay
ansible-playbook -i localhost playbook.yml
```

## Exploring Btrfs Seeding and NBD

### Btrfs Seeding

Btrfs seeding allows the creation of a read-only seed device that can be used to populate a file system.

```bash
btrfs device add -f /dev/seed-device /mnt/mybtrfs
btrfs device remove /dev/seed-device /mnt/mybtrfs
```

### Network Block Device (NBD)

For live systems, NBD can be used to share updates over the network.

```bash
modprobe nbd
qemu-nbd -c /dev/nbd0 /path/to/btrfs.img
mount /dev/nbd0 /mnt/nbd
```

## Conclusion

This architecture empowers rapid prototyping by leveraging btrfs subvolumes, reflink copies, and systemd-nspawn containers. It ensures space efficiency and resilience through overlay filesystems and can be extended to live environments using NBD. The solution also addresses partial upgrade issues by allowing updates to @base and reconstructing overlays efficiently. Future improvements can involve further automation and exploration of btrfs seeding for optimized deployment scenarios.

## References

1. Btrfs Documentation: https://btrfs.wiki.kernel.org/index.php/Main_Page
2. Systemd-nspawn Manual: https://www.freedesktop.org/software/systemd/man/systemd-nspawn.html
3. Arch Linux Pacman Documentation: https://wiki.archlinux.org/title/pacman
---
