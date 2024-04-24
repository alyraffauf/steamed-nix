{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    alyraffauf.containers.oci.freshRSS.enable =
      lib.mkEnableOption "Enable FreshRSS news client.";
    alyraffauf.containers.oci.freshRSS.port = lib.mkOption {
      description = "Port for FreshRSS.";
      default = 8080;
      type = lib.types.int;
    };
  };

  config = lib.mkIf config.alyraffauf.containers.oci.freshRSS.enable {
    virtualisation.oci-containers.containers = {
      freshrss = {
        ports = ["0.0.0.0:${toString config.alyraffauf.containers.oci.freshRSS.port}:80"];
        image = "freshrss/freshrss:latest";
        environment = {
          TZ = "America/New_York";
          CRON_MIN = "1,31";
        };
        volumes = [
          "freshrss_data:/var/www/FreshRSS/data"
          "freshrss_extensions:/var/www/FreshRSS/extensions"
        ];
      };
    };
  };
}