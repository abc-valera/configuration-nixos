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
  home.file =
    base.home.file
    // reposFolders {
      sshBin = "ssh.exe";
      sshKeyAbcValera = "/mnt/c/Users/valer/.ssh/id_ed_abc-valera";
      sshKeyHideez = "/mnt/c/Users/valer/.ssh/id_ed_hideez";
      sshKeyValeriyO3c = "/mnt/c/Users/valer/.ssh/id_ed_o3c";
    };
}
