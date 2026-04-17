{ ... }:

let
  unstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
  constants = import ../../shared/constants.nix;
  dotfiles = builtins.fetchTarball {
    url = "https://github.com/abc-valera/dotfiles/archive/refs/heads/main.tar.gz";
  };
  importAllNix = import ../../shared/import_all.nix;
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

  # Specify a custom location for the WSL configuration
  environment.variables.NIXOS_CONFIG = "$HOME/repos/abc-valera/config-nixos/src/cmd/wsl/configuration.nix";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.abc-valera = import ../../features/home-manager.nix;
  home-manager.extraSpecialArgs = { inherit dotfiles; };

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
