{
  pkgs,
  unstable,
  ...
}:

{
  # https://wiki.nixos.org/wiki/Nix-ld
  programs.nix-ld = {
    enable = true;
    libraries = [
      pkgs.stdenv.cc.cc.lib # TODO: maybe swap this one for some other c package
      pkgs.libz
    ];
  };

  # On programming languages setup: https://github.com/the-nix-way/dev-templates
  environment.systemPackages = [
    # Basic dev tools
    pkgs.git
    pkgs.gh
    pkgs.vim
    unstable.vscode
    # pkgs.direnv

    # C/C++
    pkgs.gcc

    # Nix
    pkgs.nixfmt-rfc-style
    pkgs.nixd

    # Shell
    pkgs.shellcheck
    pkgs.bash-completion

    # Go https://wiki.nixos.org/wiki/Go
    unstable.go
    unstable.gopls
    unstable.delve
    unstable.gomodifytags
    unstable.impl
    unstable.gotests
    unstable.go-tools
    unstable.gotools
    unstable.gofumpt
    unstable.air

    # Dotnet https://wiki.nixos.org/wiki/DotNET
    unstable.dotnetCorePackages.sdk_9_0-bin

    # Node.js https://wiki.nixos.org/wiki/Node.js
    unstable.nodejs

    # Rust https://wiki.nixos.org/wiki/Rust
    # unstable.cargo
    # unstable.rustc

    # Python https://wiki.nixos.org/wiki/Python
    # unstable.python3

  ];

  virtualisation.docker = {
    enable = true;
  };
  # Add the user to the "docker" group to run docker without sudo
  users.users.abc-valera.extraGroups = [ "docker" ];
}
