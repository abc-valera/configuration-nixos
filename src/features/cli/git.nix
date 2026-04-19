{ ... }:

{
  programs.git = {
    enable = true;
    config = {
      # Here all the different git users' configuration overrides are listed
      includeIf = {
        "gitdir:~/repos/abc-valera/".path = "~/repos/abc-valera/.gitconfig";
        "gitdir:~/repos/hideez/".path = "~/repos/hideez/.gitconfig";
        "gitdir:~/repos/valeriy-o3c/".path = "~/repos/valeriy-o3c/.gitconfig";
      };
    };
  };
}
