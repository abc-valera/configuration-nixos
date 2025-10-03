## Installation

Make sure that you have the following channels installed:

```
❯ sudo nix-channel --list
home-manager https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz
nixos https://nixos.org/channels/nixos-25.05
nixpkgs-unstable https://nixos.org/channels/nixos-unstable
```

Then clone the repo into `~/configuration-nixos` and run `sudo NIXOS_CONFIG=$HOME/configuration-nixos/src/cmd/configuration.nix nixos-rebuild switch`.

Note, that the `NIXOS_CONFIG` should be provided only once, the following runs of `nixos-rebuild` can be done without it: `sudo nixos-rebuild switch`.

The `/etc/nixos` can be removed entirely `sudo rm -r /etc/nixos`.

To update the system run `sudo nix-channel --update`.
