{
  description = "abc-valera's NixOS configuration";

  # TODO: maybe move everything except hardware to home-manager??

  # TODO: configure using both stable and unstable channels
  # http://librephoenix.com/2024-02-10-using-both-stable-and-unstable-packages-on-nixos-at-the-same-time

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.elitebook25 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hardware/elitebook25.nix
          ./configuration/configuration.nix
        ];
      };
      homeConfigurations.abc-valera = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/abc-valera.nix ];
      };
    };
}
