{
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    # UI programs
    pkgs.vlc
    pkgs.gimp
    pkgs.telegram-desktop
    pkgs.spotify
    pkgs.onlyoffice-bin
    pkgs.google-chrome
    pkgs.firefox

    # Themes and icons
    pkgs.capitaine-cursors
    pkgs.papirus-icon-theme
    pkgs.ibm-plex
    pkgs.nerd-fonts.blex-mono
  ];
}
