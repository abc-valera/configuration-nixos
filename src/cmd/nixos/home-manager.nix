{
  dotfiles,
  ...
}@args:

let
  base = import ../../features/home-manager.nix args;
  reposFolders = import ../../shared/repos_folder_template.nix;
in
base
// {
  home = base.home // {
    file =
      base.home.file
      // reposFolders {
        sshBin = "ssh";
        sshKeyAbcValera = "/home/abc-valera/.ssh/id_ed_personal";
        sshKeyHideez = "/home/abc-valera/.ssh/id_ed_personal";
        sshKeyValeriyO3c = "/home/abc-valera/.ssh/id_ed_o3c";
      };
    };
}
