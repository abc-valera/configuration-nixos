{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  environment.systemPackages = [
    pkgs.wget

    # Basic CLI tools
    pkgs.neofetch
    pkgs.zip
    pkgs.xz
    pkgs.unzip
    pkgs.p7zip
    pkgs.which
    pkgs.tree
    pkgs.glow # markdown previewer in terminal

    # Basic dev tools
    pkgs.git
    pkgs.vim
    pkgs-unstable.vscode
    pkgs.nixfmt-rfc-style

    # Shell-related
    pkgs.ghostty
    pkgs.fish
    pkgs.starship
  ];

  # TODO: add a run.sh script installation here
  #   let
  #   runScript = pkgs.writeShellScriptBin "run" (
  #     builtins.readFile (
  #       (pkgs.fetchFromGitHub {
  #         owner = "abc-valera";
  #         repo = "run.sh";
  #         rev = "main";
  #         sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with actual hash
  #       }) + "/run"
  #     )
  #   );
  # in
  # {
  #   home.packages = with pkgs; [
  #     runScript
  #   ];
  # }

  virtualisation.docker = {
    enable = true;
  };
  # Add the user to the "docker" group to run docker without sudo
  users.users.abc-valera.extraGroups = [ "docker" ];
}
