{
  pkgs,
  unstable,
  ...
}:

# TODO: Find a way to install things the way it's supposed to be, like rustup for Rust,
# just installing golang, etc.

{
  # On programming languages setup: https://github.com/the-nix-way/dev-templates
  environment.systemPackages = [
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
  ];

  virtualisation.docker = {
    enable = true;
  };
  # Add the user to the "docker" group to run docker without sudo
  users.users.abc-valera.extraGroups = [ "docker" ];
}
