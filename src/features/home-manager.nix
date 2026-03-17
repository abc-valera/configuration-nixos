{
  dotfiles,
  ...
}:

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
    "repos" = {
      source = "${dotfiles}/repos";
      recursive = true;
      force = true;
    };
  };

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
