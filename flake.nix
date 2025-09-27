{
  description = "abc-valera's NixOS configuration";

  # TODO: explore the usage of dev environments, look up these:
  #   https://nixos-and-flakes.thiscute.world/development/intro

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles = {
      url = "github:abc-valera/dotfiles";
      flake = false; # TODO: maybe make it a flake
    };
    # TODO: add a run.sh script installation here
    # runsh = {
    #   url = "github:abc-valera/run.sh";
    #   flake = false;
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      dotfiles,
      ...
    }:
    let
      # TODO: rename pkgs to stable and pkgs-unstable to unstable
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
      nixosConfigurations.abc-valera-elitebook25 = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = {
          inherit pkgs-unstable;
        };
        modules = [
          ./configuration/configuration.nix
          ./hardware/elitebook25.nix

          # Home Manager is used as a NixOS module.
          # Its responsible for symlinking the dotfiles.
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.abc-valera = import ./home/abc-valera.nix;

            home-manager.extraSpecialArgs = { inherit dotfiles; };
          }
        ];
      };
    };
}
