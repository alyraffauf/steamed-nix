# Framework Laptop 13 with AMD Ryzen 7640U, 32GB RAM, 1TB SSD.

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../users/aly.nix
      ../../system
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Pull latest Linux kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "lavaridge"; # Define your hostname.

  zramSwap.enable = true;
  zramSwap.memoryPercent = 25;

  powerManagement.powertop.enable = true;

  services.fwupd.enable = true;
  # # we need fwupd 1.9.7 to downgrade the fingerprint sensor firmware
  # services.fwupd.package = (import (builtins.fetchTarball {
  #   url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
  #   sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
  # }) {
  #   inherit (pkgs) system;
  # }).fwupd;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
