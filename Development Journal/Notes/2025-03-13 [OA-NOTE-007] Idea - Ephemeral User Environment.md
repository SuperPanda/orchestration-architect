# Ephemeral User Environment, Nix and NSpawn

The idea is to use Nix + NSpawn to create workspaces for users.

So setup a btrfs subvolume for a user in a loop device in ram, use it to run a nspawn 
container which will have nix as the system partition and data.

Possibly mount the systems via  sshfs or nbd. And setup subvolumes to snapshot data partition between uses.
