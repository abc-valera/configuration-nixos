{
  config,
  lib,
  pkgs,
  unstable,
  ...
}:

{
  # Globally installed packages.
  environment.systemPackages = with pkgs; [
    # General programs
    vlc
    gimp
    telegram-desktop
    spotify
    onlyoffice-bin
    google-chrome
    firefox

    # Themes and icons
    capitaine-cursors
    papirus-icon-theme
    ibm-plex
    nerd-fonts.blex-mono
  ];
}
