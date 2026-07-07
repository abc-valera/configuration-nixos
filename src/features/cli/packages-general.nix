{
  pkgs,
  run-sh,
  ...
}:

{
  # CLI programs
  environment.systemPackages = [
    run-sh.packages.${pkgs.system}.default

    # General programs
    pkgs.fastfetch
    pkgs.which
    pkgs.tree
    pkgs.glow # markdown previewer in terminal
    pkgs.ffmpeg
    pkgs.jq
    pkgs.inkscape
    pkgs.imagemagick
    pkgs.google-cloud-sdk

    # Archiving
    pkgs.zip
    pkgs.xz
    pkgs.unzip
    pkgs.p7zip

    # Networking
    pkgs.wget
    pkgs.curl
    pkgs.openssl
    pkgs.lsof
    pkgs.unixtools.netstat

    # Kernel modules
    pkgs.kmod

    # Filesystem utilities
    pkgs.exfatprogs
  ];

  programs.gnupg.agent.enable = true;
}
