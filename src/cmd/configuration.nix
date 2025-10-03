{ ... }:
let
  unstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
  dotfiles = builtins.fetchGit {
    url = "https://github.com/abc-valera/dotfiles";
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
