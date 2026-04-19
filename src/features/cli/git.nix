{ ... }:

{
  programs.git = {
    enable = true;
    config = {
      # Here all the different git users' configuration overrides are listed
      includeIf = [
        {
          condition = "gitdir:~/repos/abc-valera/";
          path = "~/repos/abc-valera/.gitconfig";
        }
        {
          condition = "gitdir:~/repos/hideez/";
          path = "~/repos/hideez/.gitconfig";
        }
        {
          condition = "gitdir:~/repos/valeriy-o3c/";
          path = "~/repos/valeriy-o3c/.gitconfig";
        }
      ];
    };
  };
}
