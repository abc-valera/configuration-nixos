{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    vscode # use a package from the unstable channel
    vim

    nixfmt-rfc-style
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
