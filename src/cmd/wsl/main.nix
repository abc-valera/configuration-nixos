{
  unstable,
  dotfiles,
  ...
}:

{
  _module.args = {
    inherit unstable;
  };

  imports = [
    ../../features/system.nix
    ../../features/cli/git.nix
    ../../features/cli/packages-dev.nix
    ../../features/cli/packages-general.nix
    ../../features/cli/packages-shell.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.abc-valera = import ../../features/home/home-manager.nix;
  home-manager.extraSpecialArgs = { inherit dotfiles; };

  # WSL-specific settings
  wsl.enable = true;
  wsl.defaultUser = "abc-valera";

  programs.nix-ld.enable = true;

  # Disable network manager in WSL
  networking.networkmanager.enable = false;

  system.stateVersion = "25.05";
}
