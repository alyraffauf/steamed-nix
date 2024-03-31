{ pkgs, lib, config, ... }: {

  imports = [ ./hypridle ./hyprlock ./hyprpaper ./hyprshade ];

  options = {
    desktopEnv.hyprland.enable =
      lib.mkEnableOption "Enables hyprland with extra apps.";
  };

  config = lib.mkIf config.desktopEnv.hyprland.enable {

    # Hypr* modules, plguins, and tools.
    desktopEnv.hyprland.hypridle.enable = lib.mkDefault true;
    desktopEnv.hyprland.hyprlock.enable = lib.mkDefault true;
    desktopEnv.hyprland.hyprpaper.enable = lib.mkDefault true;
    desktopEnv.hyprland.hyprshade.enable = lib.mkDefault true;

    # Basic apps needed to run a hyprland desktop.
    guiApps.waybar.enable = lib.mkDefault true;
    guiApps.mako.enable = lib.mkDefault true;
    guiApps.fuzzel.enable = lib.mkDefault true;
    guiApps.wlogout.enable = lib.mkDefault true;
    guiApps.alacritty.enable = lib.mkDefault true;
    guiApps.firefox.enable = lib.mkDefault true;

    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
      brightnessctl
      evince
      hyprcursor
      hyprland-protocols
      hyprnome
      hyprshot
      playerctl
      xfce.exo
      xfce.ristretto
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-media-tags-plugin
      xfce.thunar-volman
      xfce.tumbler
      xfce.xfce4-settings
      xfce.xfce4-taskmanager
      xfce.xfconf
    ];

    services.cliphist.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = builtins.readFile ./hyprland.conf;
    };

    xdg.configFile."xfce4/helpers.rc".text = ''
      TerminalEmulator=alacritty
      FileManager=thunar
      WebBrowser=firefox
    '';

    xdg.portal = {
      enable = true;
      configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.catppuccin-cursors.frappeDark;
      name = "Catppuccin-Frappe-Dark-Cursors";
      size = 24;
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
      style.name = "Catppuccin-Frappe-Compact-Mauve-Dark";
    };

    gtk = {
      enable = true;

      theme = {
        package = pkgs.catppuccin-gtk.override {
          accents = [ "mauve" ];
          size = "compact";
          variant = "frappe";
          tweaks = [ "normal" ];
        };
        name = "Catppuccin-Frappe-Compact-Mauve-Dark";
      };

      iconTheme = {
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "frappe";
          accent = "mauve";
        };
        name = "Papirus-Dark";
      };

      font = {
        name = "NotoSans Nerd Font Regular";
        package = pkgs.nerdfonts.override { fonts = [ "Noto" ]; };
        size = 11;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Catppuccin-Frappe-Compact-Mauve-Dark";
        color-scheme = "prefer-dark";
        cursor-theme = "Catppuccin-Frappe-Dark-Cursors";
        cursor-size = 24;
      };
    };
  };
}
