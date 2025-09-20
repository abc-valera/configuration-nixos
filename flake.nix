{
  description = "abc-valera's NixOS configuration";

  # TODO: maybe move everything except hardware to home-manager??

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.elitebook25 = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = {
          inherit pkgs-unstable;
        };
        modules = [
          ./hardware/elitebook25.nix
          ./configuration/configuration.nix
        ];
      };
      homeConfigurations.abc-valera = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit pkgs-unstable; };
        modules = [ ./home/abc-valera.nix ];
      };
    };
}
