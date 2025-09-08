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
    gnome-maps
    gnome-tour
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
        "org/gnome/desktop/input-sources" = {
          sources = [ ("xkb", "us") ("xkb", "ua") ];
          xkb-options = [ "ctrl:nocaps" ];
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
          home = [ "<Super>f" ];
          www = [ "<Super>b" ];
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>c";
          command = "code";
          name = "VSCode";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          binding = "<Super>t";
          command = "kgx";
          name = "Gnome Terminal";
        };
        "org/gnome/shell/app-switcher" = {
          current-workspace-only = true;
        };
        "org/gnome/shell" = {
          favorite-apps = [
            "org.telegram.desktop.desktop"
            "google-chrome.desktop"
            "org.gnome.Nautilus.desktop"
            "org.gnome.Ptyxis.desktop"
            "code.desktop"
          ];
          enabled-extensions = [
            pkgs.gnomeExtensions.just-perfection.extensionUuid
          ];
        };
        "org/gnome/shell/extensions/just-perfection" = {
          panel = false;
          panel-in-overview = true;
        };
      };
    }
  ];
}
