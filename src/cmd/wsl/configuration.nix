{ ... }:

let
  unstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
  # TODO: make sure this is not fetched every time
  dotfiles = builtins.fetchTarball {
    url = "https://github.com/abc-valera/dotfiles/archive/refs/heads/main.tar.gz";
  };
in
{
  _module.args = {
    inherit unstable;
  };

  imports = [
    <nixos-wsl/modules>
    <home-manager/nixos>

    ../../features/system.nix
    ../../features/cli/packages-dev.nix
    ../../features/cli/packages-general.nix
    ../../features/cli/packages-shell.nix
  ];

  # Specify a custom location for the WSL configuration
  environment.variables = {
    NIXOS_CONFIG = "$HOME/configuration-nixos/src/cmd/wsl/configuration.nix";
  };
  # And preserve it when using sudo
  security.sudo.extraConfig = ''
    Defaults env_keep += "NIXOS_CONFIG"
  '';

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.abc-valera = import ../../features/home-manager.nix;
  home-manager.extraSpecialArgs = { inherit dotfiles; };

  # WSL-specific shell aliases to use Windows SSH binaries
  environment.shellAliases = {
    ssh-add = "ssh-add.exe";
    ssh = ''ssh-add.exe -l > /dev/null || ssh-add.exe && echo -e "\e[92mssh-key(s) are now available in your ssh-agent until you lock your windows machine! \n \e[0m" && ssh.exe'';
  };

  # Configure git to use the Windows SSH binary
  home-manager.sharedModules = [
    {
      programs.git.extraConfig = {
        core.sshCommand = "ssh.exe";
      };
    }
  ];

  # WSL-specific settings
  wsl.enable = true;
  wsl.defaultUser = "abc-valera";

  # Disable network manager in WSL
  networking.networkmanager.enable = false;

  system.stateVersion = "25.05";
}
