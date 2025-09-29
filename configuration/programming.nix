{
  config,
  lib,
  pkgs,
  unstable,
  ...
}:

{
  environment.systemPackages = [
    pkgs.wget

    # Basic CLI tools
    pkgs.neofetch
    pkgs.zip
    pkgs.xz
    pkgs.unzip
    pkgs.p7zip
    pkgs.which
    pkgs.tree
    pkgs.glow # markdown previewer in terminal

    # Basic dev tools
    pkgs.git
    pkgs.vim
    unstable.vscode

    # Programming languages
    unstable.dotnetCorePackages.sdk_9_0-bin

    # Nix tools
    pkgs.nixfmt-rfc-style
    pkgs.nixd

    # Shell-related
    unstable.ghostty
    pkgs.fish
    pkgs.starship
  ];

  virtualisation.docker = {
    enable = true;
  };
  # Add the user to the "docker" group to run docker without sudo
  users.users.abc-valera.extraGroups = [ "docker" ];
}
