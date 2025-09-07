{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    # Extensions
    gnomeExtensions.just-perfection

    # Themes and icons
    capitaine-cursors
    papirus-icon-theme
  ];

  # Exclude unwanted GNOME packages
  environment.gnome.excludePackages = with pkgs; [
  ];

  # GNOME dconf configuration
  # To discover available settings: `dconf dump /`
  # More on gnome configuration: https://wiki.nixos.org/wiki/GNOME
  programs.dconf.profiles.user.databases = [
    {
      lockAll = true; # prevents overriding
      settings = {
        "org/gnome/desktop/interface" = {
          accent-color = "blue";
          cursor-size = lib.gvariant.mkInt32 48;
          cursor-theme = "capitaine-cursors";
          enable-hot-corners = false;
          icon-theme = "Papirus";
          show-battery-percentage = true;
          text-scaling-factor = 1.3;
          toolkit-accessibility = false;
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          speed = 0.2;
          two-finger-scrolling-enabled = true;
        };
        "org/gnome/desktop/sound" = {
          event-sounds = false;
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = ":";
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          control-center = [ "<Super>comma" ];
          # custom-keybindings =
          # CONTINUE HERE
          # todo: add ssh keys, push to github and finish the gnome configuration
        };

        # Enable extensions
        "org/gnome/shell" = {
          enabled-extensions = [
            pkgs.gnomeExtensions.just-perfection.extensionUuid
          ];
        };

        # Configure Extensions
        "org/gnome/shell/extensions/just-perfection" = {
          panel = false;
          panel-in-overview = true;
        };
      };
    }
  ];
}
