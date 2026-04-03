{
  pkgs,
  ...
}:

{
  # CLI programs
  environment.systemPackages = [
    # General programs
    pkgs.neofetch
    pkgs.which
    pkgs.tree
    pkgs.glow # markdown previewer in terminal
    pkgs.ffmpeg

    # Archiving
    pkgs.zip
    pkgs.xz
    pkgs.unzip
    pkgs.p7zip

    # Networking
    pkgs.wget
    pkgs.curl
    pkgs.lsof
    pkgs.unixtools.netstat

    # Kernel modules
    pkgs.kmod

    # Filesystem utilities
    pkgs.exfatprogs
  ];

  programs.gnupg.agent.enable = true;
}
