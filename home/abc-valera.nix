{
  config,
  dotfiles,
  ...
}:

# TODO: add dotfiles for the ghostty terminal, enable blex nerd font for the ghostty terminal app (and the white theme too)
# TODO: move dotfiles to a separate github repo

# home-manager is used only to symlink the files to the home folder

{
  home.username = "abc-valera";
  home.homeDirectory = "/home/abc-valera";

  # Symlink all the dotfiles to the home directory.
  # Such structure will map everything from the dotfiles to ~ as is.
  home.file = {
    ".config" = {
      source = "${dotfiles}/.config";
      recursive = true;
      force = true;
    };
    ".bashrc" = {
      source = "${dotfiles}/.bashrc";
      force = true;
    };
  };

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
