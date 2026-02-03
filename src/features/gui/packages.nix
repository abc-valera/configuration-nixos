{
  pkgs,
  unstable,
  ...
}:

{
  environment.systemPackages = [
    # UI programs
    pkgs.vlc
    pkgs.gimp
    pkgs.telegram-desktop
    pkgs.spotify
    pkgs.onlyoffice-desktopeditors
    pkgs.google-chrome
    pkgs.firefox
    unstable.vscode
    unstable.code-cursor # maybe use this instead: code-cursor-fhs

    # Themes and icons
    pkgs.capitaine-cursors
    pkgs.papirus-icon-theme
    pkgs.ibm-plex
    pkgs.nerd-fonts.blex-mono
  ];
}
