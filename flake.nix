{
  description = "abc-valera's NixOS configuration";

  # TODO: take a look on these:
  # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-flake-configuration-explained
  # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-flake-and-module-system
  # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations.abc-valera-elitebook25 = nixpkgs.lib.nixosSystem {
        modules = [
          ./hardware-elitebook25.nix
          ./configuration.nix
        ];
      };
    };
}
