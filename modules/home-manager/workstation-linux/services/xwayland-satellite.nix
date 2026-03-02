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

    systemd.user.services."xwayland-satellite" = {
      Service = {
        ExecStart = "${pkgs.xwayland-satellite}/bin/${pkgs.xwayland-satellite.meta.mainProgram}";
        Restart = "on-failure";
        RestartSec = 2;
        StartLimitBurst = 5;
      };
      Unit = {
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
    };
  };
}
