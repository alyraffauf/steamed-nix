{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {alyraffauf.apps.waybar.enable = lib.mkEnableOption "Enables waybar.";};

  config = lib.mkIf config.alyraffauf.apps.waybar.enable {
    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
      blueberry
      pavucontrol
      (nerdfonts.override {fonts = ["Noto"];})
    ];

    xdg.configFile."waybar/style.css".source = ./waybar.css;

    programs.waybar.enable = true;
    programs.waybar.settings = {
      mainBar = {
        height = 36;
        layer = "top";
        output = ["*"];
        position = "top";
        reload_style_on_change = true;
        modules-left = ["hyprland/workspaces" "river/tags" "sway/workspaces" "hyprland/submap"];
        modules-center = ["clock"];
        modules-right = [
          "tray"
          "bluetooth"
          # "network"
          "pulseaudio"
          # "wireplumber"
          "group/power"
          "custom/logout"
        ];
        "hyprland/workspaces" = {
          "all-outputs" = true;
          "format" = "{icon} {name}";
          "format-icons" = {
            "default" = "󰝥";
            "active" = "󰪥";
          };
          "sort-by" = "id";
        };
        "hyprland/submap" = {
          "on-click" = "${pkgs.hyprland}/bin/hyprctl dispatch submap reset";
        };
        "hyprland/window" = {
          "format" = "";
          "max-length" = 100;
          "separate-outputs" = true;
          "icon" = true;
        };
        "sway/workspaces" = {
          "all-outputs" = true;
        };
        "sway/window" = {
          "max-length" = 100;
        };
        "river/window" = {
          "max-length" = 100;
        };
        "river/tags" = {
          "num-tags" = 4;
        };
        "clock" = {
          # "tooltip-format" = "{:%Y-%m-%d | %H:%M}";
          "interval" = 60;
          "format" = "{:%I:%M%p}";
        };
        "group/power" = {
          "orientation" = "inherit";
          "drawer" = {
            "transition-duration" = 500;
            "children-class" = "not-power";
            "transition-left-to-right" = false;
          };
          "modules" = [
            "battery"
            "power-profiles-daemon"
            "inhibitor"
          ];
        };
        "battery" = {
          "states" = {"critical" = 20;};
          "format" = "{icon}";
          "format-icons" = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          "tooltip-format" = ''
            {capacity}%: {timeTo}.
            Using {power} watts.'';
        };
        "inhibitor" = {
          "what" = "sleep";
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        "bluetooth" = {
          "format" = "󰂯";
          "format-disabled" = ""; # an empty format will hide the module
          "format-connected" = "󰂯　{num_connections} connected";
          "tooltip-format" = "{controller_alias}	{controller_address}";
          "tooltip-format-connected" = ''
            {controller_alias}	{controller_address}

            {device_enumerate}'';
          "tooltip-format-enumerate-connected" = "{device_alias}	{device_address}";
          "on-click" = "${pkgs.blueberry}/bin/blueberry";
        };
        "pulseaudio" = {
          "format" = "{icon}";
          "format-bluetooth" = "{volume}% {icon}󰂯";
          "format-muted" = "";
          "format-icons" = {
            "headphones" = "󰋋";
            "handsfree" = "󰋎";
            "headset" = "󰋎";
            "default" = [ "" "" "" ];
          };
          "scroll-step" = 5;
          "ignored-sinks" = ["Easy Effects Sink"];
          "on-click" = "${pkgs.pavucontrol}/bin/pavucontrol -t 3";
        };
        "network" = {
          "format-wifi" = "{icon}";
          "format-ethernet" = "󰈀";
          "format-disconnected" = "⚠";
          "format-icons" = ["󰤟" "󰤢" "󰤥" "󰤨" ];
          "tooltip-format" = "{ifname} via {gwaddr} 󰊗";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%) {icon}";
          "tooltip-format-ethernet" = "{ifname} ";
          "tooltip-format-disconnected" = "Disconnected";
          "on-click" = "${pkgs.alacritty}/bin/alacritty --class nmtui -e ${pkgs.networkmanager}/bin/nmtui";
        };
        "tray" = {"spacing" = 15;};
        "custom/logout" = {
          "on-click" = "${pkgs.wlogout}/bin/wlogout";
          "format" = "󰗽";
        };
        "power-profiles-daemon" = {
          "format" = "{icon}";
          "tooltip-format" = ''
            Profile: {profile}
            Driver: {driver}'';
          "tooltip" = true;
          "format-icons" = {
            "default" = "󱐌";
            "performance" = "󱐌";
            "balanced" = "󰗑";
            "power-saver" = "󰌪";
          };
        };
      };
    };
  };
}