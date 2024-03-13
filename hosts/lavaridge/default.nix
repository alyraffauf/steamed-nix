# Framework Laptop 13 with AMD Ryzen 7640U, 32GB RAM, 1TB SSD.

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../users/aly
      ../../system
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Pull latest Linux kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "lavaridge"; # Define your hostname.

  powerManagement.powertop.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
