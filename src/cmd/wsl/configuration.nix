{ ... }:

let
  unstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
  constants = import ../../shared/constants.nix;
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
  environment.variables.NIXOS_CONFIG = "${constants.nixosConfigPath}/src/cmd/wsl/configuration.nix";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.abc-valera = import ../../features/home-manager.nix;
  home-manager.extraSpecialArgs = { inherit dotfiles; };

  # WSL-specific settings
  wsl.enable = true;
  wsl.defaultUser = "abc-valera";

  programs.fish.shellAliases = {
    ssh = "ssh.exe";
    ssh-add = "ssh-add.exe";
  };

  programs.fish.interactiveShellInit = ''
    if test "$(git config --global --get core.sshCommand)" != "ssh.exe"
      git config --global core.sshCommand "ssh.exe"
    end
  '';

  programs.bash.shellAliases = {
    ssh = "ssh.exe";
    ssh-add = "ssh-add.exe";
  };

  programs.bash.interactiveShellInit = ''
    if [ "$(git config --global --get core.sshCommand)" != "ssh.exe" ]; then
      git config --global core.sshCommand "ssh.exe"
    fi
  '';

  # Disable network manager in WSL
  networking.networkmanager.enable = false;

  system.stateVersion = "25.05";
}
