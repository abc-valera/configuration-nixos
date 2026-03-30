{
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

  # Disable GNOME's built-in SSH agent in favour of programs.ssh.startAgent
  services.gnome.gcr-ssh-agent.enable = false;

  environment.systemPackages = with pkgs; [
    # Extensions
    gnomeExtensions.just-perfection
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
        "org/gnome/Console" = {
          theme = "day";
          use-system-font = false;
          custom-font = "BlexMono Nerd Font Mono 12";
        };

        "org/gnome/desktop/interface" = {
          accent-color = "blue";
          cursor-size = lib.gvariant.mkInt32 48;
          cursor-theme = "capitaine-cursors";
          enable-hot-corners = false;
          gtk-enable-primary-paste = false;
          icon-theme = "Papirus";
          show-battery-percentage = true;
          text-scaling-factor = 1.3;
        };
        "org/gnome/desktop/input-sources" = {
          sources = [
            (lib.gvariant.mkTuple [
              "xkb"
              "us"
            ])
            (lib.gvariant.mkTuple [
              "xkb"
              "ua"
            ])
          ];
          xkb-options = [ "ctrl:nocaps" ];
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          speed = 0.2;
          two-finger-scrolling-enabled = true;
        };
        "org/gnome/desktop/peripherals/keyboard" = {
          repeat = false;
        };

        "org/gnome/desktop/session" = {
          idle-delay = lib.gvariant.mkUint32 0; # disable automatic screen locking
        };
        "org/gnome/desktop/sound" = {
          event-sounds = false;
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = ":";
        };

        # Wallpaper settings
        "org/gnome/desktop/background" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
          picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
          primary-color = "#241f31";
          secondary-color = "#000000";
        };
        "org/gnome/desktop/screensaver" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
          primary-color = "#241f31";
          secondary-color = "#000000";
        };

        "org/gnome/settings-daemon/plugins/power" = {
          idle-dim = false;
          sleep-inactive-ac-timeout = lib.gvariant.mkInt32 1800;
          sleep-inactive-ac-type = "suspend";
          sleep-inactive-battery-timeout = lib.gvariant.mkInt32 1800;
          sleep-inactive-battery-type = "suspend";
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
          name = "Gnome Console";
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
