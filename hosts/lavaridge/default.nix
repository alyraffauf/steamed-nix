# Framework Laptop 13 with AMD Ryzen 7640U, 32GB RAM, 1TB SSD.
{
  config,
  inputs,
  lib,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./disko.nix
    ./hardware.nix
    ./home.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  networking.hostName = "lavaridge";

  system.stateVersion = "24.05";

  alyraffauf = {
    apps = {
      steam.enable = true;
      podman.enable = true;
      virt-manager.enable = true;
    };

    base.enable = true;

    desktop = {
      enable = true;

      greetd = {
        enable = true;

        autologin = {
          enable = true;
          user = "aly";
        };
      };

      hyprland.enable = true;
    };

    services = {
      syncthing.enable = true;
      tailscale.enable = true;
    };

    users.aly = {
      enable = true;
      password = "$y$j9T$NSS7QcEtN4yiigPyofwlI/$nxdgz0lpySa0heDMjGlHe1gX3BWf48jK6Tkfg4xMEs6";
    };
  };
}
