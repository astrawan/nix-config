{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.services.xwayland-satellite;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      xwayland-satellite
    ];

    home.sessionVariables.DISPLAY = ":0";

    xdg.configFile."systemd/user/default.target.wants/xwayland-satellite.service" = {
      source = "${pkgs.xwayland-satellite}/share/systemd/user/xwayland-satellite.service";
    };
  };
}
