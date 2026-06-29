{
  dotfiles,
  ...
}:

# home-manager is used only to symlink the files to the home folder

{
  home.username = "abc-valera";
  home.homeDirectory = "/home/abc-valera";

  home.sessionPath = [ "$GOBIN" ];

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

    # This script is a wrapper around ssh-keygen that
    # ensures that the signing key is added to the ssh-agent on use.
    # It is used as the gpg.ssh.program for git commit signing.
    ".local/bin/git-ssh-sign" = {
      executable = true;
      force = true;
      source = ./git-ssh-sign.bash;
    };

    "repos/abc-valera/.gitconfig" = {
      force = true;
      text = ''
        [user]
            name = abc-valera
            email = valeriy.tymofieiev@gmail.com
            signingKey = /home/abc-valera/.ssh/id_ed_personal

        [github]
            user = abc-valera

        [url "github-personal:"]
            insteadOf = git@github.com:

        [gpg "ssh"]
            program = /home/abc-valera/.local/bin/git-ssh-sign
      '';
    };

    "repos/hideez/.gitconfig" = {
      force = true;
      text = ''
        [user]
            name = abc-valera
            email = valeriy.tymofieiev@gmail.com
            signingKey = /home/abc-valera/.ssh/id_ed_personal

        [github]
            user = abc-valera

        [url "github-personal:"]
            insteadOf = git@github.com:

        [gpg "ssh"]
            program = /home/abc-valera/.local/bin/git-ssh-sign
      '';
    };

    "repos/valeriy-o3c/.gitconfig" = {
      force = true;
      text = ''
        [user]
            name = valeriy-o3c
            email = valeriy@o3c.no
            signingKey = /home/abc-valera/.ssh/id_ed_o3c

        [github]
            user = valeriy-o3c

        [url "github-o3c:"]
            insteadOf = git@github.com:

        [gpg "ssh"]
            program = /home/abc-valera/.local/bin/git-ssh-sign
      '';
    };
  };

  # Start ssh-agent as a user service
  services.ssh-agent.enable = true;

  # SSH config
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "github-personal" = {
        User = "git";
        Hostname = "github.com";
        IdentityFile = "~/.ssh/id_ed_personal";
        IdentitiesOnly = "yes";
        AddKeysToAgent = "3600";
      };
      "github-o3c" = {
        User = "git";
        Hostname = "github.com";
        IdentityFile = "~/.ssh/id_ed_o3c";
        IdentitiesOnly = "yes";
        AddKeysToAgent = "3600";
      };
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
