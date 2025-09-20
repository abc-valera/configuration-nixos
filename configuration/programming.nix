{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  environment.systemPackages = [
    pkgs.git
    pkgs.wget
    pkgs.vim

    pkgs.nixfmt-rfc-style

    pkgs-unstable.vscode
  ];

  programs.git = {
    enable = true;

    config = {
      user = {
        name = "abc-valera";
        email = "valeriy.tymofieiev@gmail.com";
      };
      github = {
        user = "abc-valera";
      };
      init = {
        defaultBranch = "main";
      };
      commit = {
        verbose = true;
      };
      help = {
        autocorrect = 10;
      };
      diff = {
        algorithm = "histogram";
      };
      branch = {
        sort = "-committerdate";
      };
      url."git@github.com:" = {
        insteadOf = "https://github.com/";
      };
    };
  };

  virtualisation.docker = {
    enable = true;
  };
  # Add the user to the "docker" group to run docker without sudo
  users.users.abc-valera.extraGroups = [ "docker" ];
}
