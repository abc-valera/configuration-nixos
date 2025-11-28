## Installation

Setup a fresh nixos installation. If Gnome is used, disable automatic sleep in the power settings.

Then add and update the following channels:

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
sudo nix-channel --add https://nixos.org/channels/nixos-25.05 nixos
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixpkgs-unstable

sudo nix-channel --update
```

Download the repo somehow? and place it into `~/configuration-nixos`. Copy the hardware configuration from the `/etc/nixos` into `src/hardware/elitebook25`. Then run `sudo NIXOS_CONFIG=$HOME/configuration-nixos/src/cmd/configuration.nix nixos-rebuild switch`. Note, that the `NIXOS_CONFIG` var should be provided only once, the following runs of `nixos-rebuild` can be done without it: `sudo nixos-rebuild switch`.

The `/etc/nixos` can be removed entirely `sudo rm -r /etc/nixos`.

To update the system run `sudo nix-channel --update`.

sudo nixos-rebuild switch --upgrade
