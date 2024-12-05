{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 6;

  environment = {
    variables.FLAKE = lib.mkDefault "github:alyraffauf/steamed-nix";

    systemPackages = with pkgs; [
      git
      htop
      inxi
      python3
    ];
  };

  programs = {
    dconf.enable = true; # Needed for home-manager

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nh.enable = true;
  };

  networking.networkmanager.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
      persistent = true;
      randomizedDelaySec = "60min";
    };

    # Run GC when there is less than 100MiB left.
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';

    optimise.automatic = true;

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];

      substituters = [
        "https://alyraffauf.cachix.org"
        "https://cache.nixos.org/"
        "https://jovian-nixos.cachix.org"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
      ];

      trusted-public-keys = [
        "alyraffauf.cachix.org-1:GQVrRGfjTtkPGS8M6y7Ik0z4zLt77O0N25ynv2gWzDM="
        "jovian-nixos.cachix.org-1:mAWLjAxLNlfxAnozUjOqGj4AxQwCl7MXwOfu7msVlAo="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];

      trusted-users = ["aly"];
    };
  };

  nixpkgs = {
    config.allowUnfree = true; # Allow unfree packages
    overlays = [self.overlays.default];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;

      publish = {
        enable = true;
        addresses = true;
        userServices = true;
        workstation = true;
      };
    };

    openssh = {
      enable = true;
      openFirewall = true;
      settings.PasswordAuthentication = false;
    };
  };

  system.autoUpgrade = {
    enable = lib.mkDefault true;
    allowReboot = false;
    dates = "02:00";
    flags = ["--accept-flake-config"];
    flake = config.environment.variables.FLAKE;
    operation = "switch";
    persistent = true;
    randomizedDelaySec = "60min";

    rebootWindow = {
      lower = "02:00";
      upper = "06:00";
    };
  };
}
