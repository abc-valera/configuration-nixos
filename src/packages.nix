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
    pkgs.onlyoffice-bin
    pkgs.google-chrome
    pkgs.firefox

    # CLI programs
    pkgs.wget
    pkgs.curl
    pkgs.lsof
    pkgs.unixtools.netstat

    pkgs.neofetch
    pkgs.zip
    pkgs.xz
    pkgs.unzip
    pkgs.p7zip
    pkgs.which
    pkgs.tree
    pkgs.glow # markdown previewer in terminal

    # Terminal related
    pkgs.fish
    pkgs.starship

    # Themes and icons
    pkgs.capitaine-cursors
    pkgs.papirus-icon-theme
    pkgs.ibm-plex
    pkgs.nerd-fonts.blex-mono
  ];
}
