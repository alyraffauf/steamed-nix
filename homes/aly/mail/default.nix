{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  mkPassword = secret: "${lib.getExe' pkgs.coreutils "cat"} ${secret}";
in {
  accounts.email.accounts = {
    "alyraffauf@fastmail.com" = {
      address = "alyraffauf@fastmail.com";
      aliases = ["aly@raffauflabs.com"];
      flavor = "fastmail.com";
      himalaya.enable = true;
      passwordCommand = mkPassword osConfig.age.secrets.alyraffaufFastmail.path;
      primary = true;
      realName = "Aly Raffauf";

      signature = {
        text = ''
          Thank you,
          Aly Raffauf
          https://aly.RaffaufLabs.com
          https://alyraffauf.github.com
        '';

        showSignature = "append";
      };

      thunderbird = {
        enable = true;
        profiles = ["default"];
      };

      userName = "alyraffauf@fastmail.com";
    };

    "achacega@gmail.com" = {
      address = "achacega@gmail.com";
      aliases = ["alyraffauf@gmail.com"];
      flavor = "gmail.com";
      himalaya.enable = true;
      passwordCommand = mkPassword osConfig.age.secrets.achacegaGmail.path;
      realName = "Aly Raffauf";

      signature = {
        text = ''
          --
          Aly Raffauf (née Chace)
        '';
      };

      thunderbird = {
        enable = true;
        profiles = ["default"];
      };

      userName = "achacega@gmail.com";
    };

    "aly.chace@joingsg.com" = {
      address = "aly.chace@joingsg.com";
      flavor = "gmail.com";
      realName = "Aly Raffauf";

      signature = {
        text = ''
          Aly Raffauf (née Chace)
          Content Operations Specialist 1
          Global Savings Group
        '';

        showSignature = "append";
      };

      thunderbird = {
        enable = true;
        profiles = ["work"];
      };

      userName = "aly.chace@joingsg.com";
    };
  };

  programs = {
    himalaya.enable = true;

    thunderbird = {
      enable = true;
      profiles = let
        settings = {"mailnews.message_display.disable_remote_image" = false;};
      in {
        default = {
          inherit settings;
          isDefault = true;
        };
        work = {inherit settings;};
      };
    };
  };

  xdg.desktopEntries.thunderwork = {
    categories = ["Application" "Network" "Chat" "Email" "Feed" "GTK" "News"];
    exec = "thunderbird -P work --name thunderwork %U";
    comment = "Read and write e-mails or RSS feeds, or manage tasks on calendars.";
    genericName = "Email Client";
    icon = "thunderbird";
    mimeType = ["message/rfc822" "x-scheme-handler/mailto" "text/calendar" "text/x-vcard"];
    name = "Thunderbird (work)";
    startupNotify = true;
    terminal = false;
    settings = {
      StartupWMClass = "thunderwork";
    };
  };
}