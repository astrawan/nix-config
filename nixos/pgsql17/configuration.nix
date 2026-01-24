{ config, lib, pkgs, ... }:

{
  networking.hostName = "pgsql17";

  # Set your time zone.
  time.timeZone = "${config.devlive.host.timeZone}";

  # Select internationalisation properties.
  i18n.defaultLocale = "${config.devlive.host.defaultLocale}";

  environment.systemPackages = with pkgs; [
    python3
    rclone
  ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
