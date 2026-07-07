{
  description = "abc-valera NixOS configuration";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles.url = "github:abc-valera/dotfiles/main";

    run-sh = {
      url = "github:abc-valera/run.sh/main";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nixos-wsl,
      dotfiles,
      run-sh,
      ...
    }:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      specialArgs = {
        inherit unstable dotfiles run-sh;
      };
    in
    {
      nixosConfigurations = {
        elitebook25 = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            ./src/cmd/nixos/main.nix
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            nixos-wsl.nixosModules.default
            home-manager.nixosModules.home-manager
            ./src/cmd/wsl/main.nix
          ];
        };
      };
    };
}
