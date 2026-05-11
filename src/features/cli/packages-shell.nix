{
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    pkgs.bash-completion
    pkgs.fish
    pkgs.starship
  ];

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish.enable = true;
  programs.fish.shellAliases = {
      claude-o3c = "CLAUDE_CONFIG_DIR=~/repos/valeriy-o3c/.claude claude";
  };
}
