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
      pkgs.glibc
    ];
  };

  environment.variables = {
    RUST_SRC_PATH = "${unstable.rust.packages.stable.rustPlatform.rustLibSrc}";
  };

  # On programming languages setup: https://github.com/the-nix-way/dev-templates
  environment.systemPackages = [
    # Basic dev tools
    pkgs.git
    pkgs.gh
    pkgs.vim
    unstable.vscode
    unstable.code-cursor # maybe use this instead: code-cursor-fhs
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
    unstable.powershell

    # Node.js https://wiki.nixos.org/wiki/Node.js
    unstable.nodejs

    # Rust https://wiki.nixos.org/wiki/Rust
    unstable.cargo
    unstable.rustc
    unstable.rust-analyzer
    unstable.rustfmt

    # Python https://wiki.nixos.org/wiki/Python
    unstable.python3

    # Perl
    unstable.perl
  ];

  virtualisation.docker = {
    enable = true;
  };
  # Add the user to the "docker" group to run docker without sudo
  users.users.abc-valera.extraGroups = [ "docker" ];
}
