{
  description = "abc-valera's NixOS configuration";

  # TODO: take a look on these:
  # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-flake-configuration-explained
  # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-flake-and-module-system
  # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager

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
    }@inputs:
    {
      nixosConfigurations.abc-valera-elitebook25 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hardware-elitebook25.nix
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.abc-valera = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
}
