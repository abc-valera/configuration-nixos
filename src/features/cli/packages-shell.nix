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

  programs.fish.enable = true;
}
