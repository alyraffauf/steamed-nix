{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.ar.home;
  hyprctl = lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl";
  pkill = lib.getExe' pkgs.procps "pkill";
  virtKeyboard = lib.getExe' pkgs.squeekboard "squeekboard";
in {
  clamshell = pkgs.writeShellScript "hyprland-clamshell" ''
    NUM_MONITORS=$(${hyprctl} monitors all | grep Monitor | wc --lines)
    if [ "$1" == "on" ]; then
      if [ $NUM_MONITORS -gt 1 ]; then
        ${hyprctl} keyword monitor "eDP-1, disable"
      fi
    elif [ "$1" == "off" ]; then
    ${
      lib.strings.concatMapStringsSep "${hyprctl}\n"
      (monitor: ''${hyprctl} keyword monitor "${monitor}"'')
      cfg.desktop.hyprland.laptopMonitors
    }
    fi
  '';

  tablet = pkgs.writeShellScript "hyprland-tablet" ''
    STATE=`${lib.getExe pkgs.dconf} read /org/gnome/desktop/a11y/applications/screen-keyboard-enabled`

    if [ $STATE -z ] || [ $STATE == "false" ]; then
      if ! [ `pgrep -f ${virtKeyboard}` ]; then
        ${virtKeyboard} &
      fi
      ${lib.getExe pkgs.dconf} write /org/gnome/desktop/a11y/applications/screen-keyboard-enabled true
    elif [ $STATE == "true" ]; then
      ${lib.getExe pkgs.dconf} write /org/gnome/desktop/a11y/applications/screen-keyboard-enabled false
    fi
  '';
}
