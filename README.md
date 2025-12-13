## Installation

### Shared steps

Clone the repo into the home directory:

```
cd
nix-shell -p git
git clone https://github.com/abc-valera/configuration-nixos.git
```

Add and update the following channels:

```
sudo nix-channel --add https://nixos.org/channels/nixos-25.05 nixos
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixpkgs-unstable
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager

sudo nix-channel --update
```

The `/etc/nixos` can be removed entirely `sudo rm -r /etc/nixos`.

To update the system run `sudo nixos-rebuild switch --upgrade`.

### WSL Installation

Add an additional channel:

```
sudo nix-channel --add https://github.com/nix-community/NixOS-WSL/archive/refs/heads/release-25.05.tar.gz nixos-wsl

sudo nix-channel --update
```

Then run the `sudo NIXOS_CONFIG=$HOME/configuration-nixos/src/cmd/wsl/configuration.nix nixos-rebuild switch`. Note, that the `NIXOS_CONFIG` var should be provided only once, the following runs of `nixos-rebuild` can be done without it: `sudo nixos-rebuild switch`.

### NixOS Installation

Copy the hardware configuration from the `/etc/nixos` into `src/cmd/nixos/hardware/<machine-name>` if not already exists. 

Then run the `sudo NIXOS_CONFIG=$HOME/configuration-nixos/src/cmd/nixos/configuration.nix nixos-rebuild switch`. Note, that the `NIXOS_CONFIG` var should be provided only once, the following runs of `nixos-rebuild` can be done without it: `sudo nixos-rebuild switch`.

## Resources

https://nix-community.github.io/NixOS-WSL
