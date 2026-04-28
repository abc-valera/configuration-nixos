{ ... }:

let
  unstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
  dotfiles = builtins.fetchTarball {
    url = "https://github.com/abc-valera/dotfiles/archive/refs/heads/main.tar.gz";
  };
in
{
  _module.args = {
    inherit unstable;
  };

  imports = [
    <nixos-wsl/modules>
    <home-manager/nixos>

    ../../features/system.nix
    ../../features/cli/git.nix
    ../../features/cli/packages-dev.nix
    ../../features/cli/packages-general.nix
    ../../features/cli/packages-shell.nix
  ];

  # Point nixos-rebuild to the config in the repo, keeping the other default NIX_PATH entries intact
  nix.nixPath = [
    "nixos-config=/home/abc-valera/repos/abc-valera/config-nixos/src/cmd/wsl/configuration.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.abc-valera = import ../../features/home-manager.nix;
  home-manager.extraSpecialArgs = { inherit dotfiles; };

  # WSL-specific settings
  wsl.enable = true;
  wsl.defaultUser = "abc-valera";

  # Disable network manager in WSL
  networking.networkmanager.enable = false;

  system.stateVersion = "25.05";
}
