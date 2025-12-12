{ ... }:

# TODO: check if it's possible to make windows dual boot reproducible

let
  unstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
  # TODO: make sure this is not fetched every time
  dotfiles = builtins.fetchTarball {
    url = "https://github.com/abc-valera/dotfiles/archive/refs/heads/main.tar.gz";
  };
  importAllNix =
    dir:
    let
      contents = builtins.readDir dir;
    in
    map (name: dir + "/${name}") (
      builtins.filter (name: builtins.match ".*\\.nix$" name != null) (builtins.attrNames contents)
    );
in
{
  _module.args = {
    inherit unstable;
  };

  imports = [
    ./hardware/elitebook25.nix

    <home-manager/nixos>

    ../../features/system.nix
  ]
  ++ importAllNix ../../features/cli
  ++ importAllNix ../../features/gui;

  # Specify a custom location for the NixOS configuration
  environment.variables = {
    NIXOS_CONFIG = "$HOME/configuration-nixos/src/cmd/nixos/configuration.nix";
  };
  # And preserve it when using sudo
  security.sudo.extraConfig = ''
    Defaults env_keep += "NIXOS_CONFIG"
  '';

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.abc-valera = import ../../features/home-manager.nix;
  home-manager.extraSpecialArgs = { inherit dotfiles; };

  virtualisation.docker = {
    enable = true;
  };
  # Add the user to the "docker" group to run docker without sudo
  users.users.abc-valera.extraGroups = [ "docker" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network Manager
  networking.networkmanager.enable = true;

  # X11 keymap configuration
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # CUPS printing service
  services.printing.enable = true;

  # Sound with PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  system.stateVersion = "25.05";
}
