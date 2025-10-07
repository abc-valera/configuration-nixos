{ ... }:

# TODO: check if it's possible to make windows dual boot reproducible

let
  unstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
  # TODO: make sure this is not fetched every time
  dotfiles = builtins.fetchTarball {
    url = "https://github.com/abc-valera/dotfiles/archive/refs/heads/main.tar.gz";
  };
in
{
  # Specify a custom location for the NixOS configuration
  environment.variables = {
    NIXOS_CONFIG = "$HOME/configuration-nixos/src/cmd/configuration.nix";
  };
  # And preserve it when using sudo
  security.sudo.extraConfig = ''
    Defaults env_keep += "NIXOS_CONFIG"
  '';

  imports = [
    ../hardware/elitebook25.nix

    <home-manager/nixos>

    ../gnome.nix
    ../packages.nix
    ../programming.nix
    ../system.nix
  ];

  nixpkgs.config.allowUnfree = true;

  _module.args = {
    inherit unstable;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.abc-valera = import ../home/abc-valera.nix;
  home-manager.extraSpecialArgs = { inherit dotfiles; };
}
