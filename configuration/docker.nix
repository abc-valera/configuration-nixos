{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  virtualisation.docker = {
    enable = true;
  };
  # Add the users to the "docker" group to run docker without sudo
  users.users.abc-valera.extraGroups = [ "docker" ];
}
