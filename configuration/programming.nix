{
  config,
  lib,
  pkgs,
  unstable,
  ...
}:

# TODO: Find a way to install things the way it's supposed to be, like rustup for Rust,
# just installing golang, etc.

{
  # On programming languages setup: https://github.com/the-nix-way/dev-templates
  environment.systemPackages = [
    # Networking tools
    pkgs.wget
    pkgs.curl
    pkgs.lsof
    pkgs.unixtools.netstat

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
    pkgs.gh
    pkgs.vim
    unstable.vscode
    # pkgs.direnv

    # Nix
    pkgs.nixfmt-rfc-style
    pkgs.nixd

    # Go
    unstable.go
    unstable.gopls
    unstable.delve
    unstable.gomodifytags
    unstable.impl
    unstable.gotests
    unstable.go-tools
    unstable.gotools

    # Dotnet
    unstable.dotnetCorePackages.sdk_9_0-bin

    # Node.js
    # unstable.nodejs

    # Rust (https://wiki.nixos.org/wiki/Rust)
    # unstable.cargo
    # unstable.rustc

    # Python

    # Shell-related
    pkgs.ghostty
    pkgs.fish
    pkgs.starship
  ];

  virtualisation.docker = {
    enable = true;
  };
  # Add the user to the "docker" group to run docker without sudo
  users.users.abc-valera.extraGroups = [ "docker" ];
}
