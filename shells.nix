{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    ghostty
    fish
    starship
  ];

  programs.starship = {
    enable = true;
    settings = {
    };
  };

  programs.bash = {
    # Shell aliases for all users
    shellAliases = {
      grep = "grep --color=auto";
    };

    # Additional bash initialization
    interactiveShellInit = ''
      eval "$(starship init bash)"
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fish_config theme choose 'Snow Day'
      starship init fish | source # Enable starship prompt
    '';
  };

  # TODO: enable blex nerd font for the ghostty terminal app (and the white theme too)
  # Use symlinks for this, with home-manager?
}
