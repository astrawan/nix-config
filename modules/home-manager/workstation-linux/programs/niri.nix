{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
  cfg = config.devlive.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      xwayland-satellite
    ];
    xdg.configFile."niri/animations.kdl" = {
      source = ../../../../assets/config/niri/animations.kdl;
    };
    xdg.configFile."niri/config.kdl" = {
      source = ../../../../assets/config/niri/config.kdl;
    };
    xdg.configFile."niri/binds.kdl" = {
      source = (
        if (desktop.type == "noctalia" && desktop.noctalia.package == pkgs.noctalia-shell) then
          ../../../../assets/config/niri/binds-noctalia-4.kdl
        else if (desktop.type == "noctalia" && desktop.noctalia.package == pkgs.noctalia-shell-5) then
          ../../../../assets/config/niri/binds-noctalia-5.kdl
        else
          ../../../../assets/config/niri/binds.kdl
      );
    };
    xdg.configFile."niri/input.kdl" = {
      source = ../../../../assets/config/niri/input.kdl;
    };
    xdg.configFile."niri/output.kdl" = {
      source = ../../../../assets/config/niri/output.kdl;
    };
    xdg.configFile."niri/layer-rule.kdl" = {
      source = (
        if (desktop.type == "noctalia" && desktop.noctalia.package == pkgs.noctalia-shell) then
          ../../../../assets/config/niri/layer-rule-noctalia-4.kdl
        else if (desktop.type == "noctalia" && desktop.noctalia.package == pkgs.noctalia-shell-5) then
          ../../../../assets/config/niri/layer-rule-noctalia-5.kdl
        else 
          ../../../../assets/config/niri/layer-rule.kdl
      );
    };
    xdg.configFile."niri/layout.kdl" = {
      source = ../../../../assets/config/niri/layout.kdl;
    };
    xdg.configFile."niri/spawn-at-startup.kdl" = {
      source = (
        if (desktop.type == "noctalia" && desktop.noctalia.package == pkgs.noctalia-shell) then
          ../../../../assets/config/niri/spawn-at-startup-noctalia-4.kdl
        else if (desktop.type == "noctalia" && desktop.noctalia.package == pkgs.noctalia-shell-5) then
          ../../../../assets/config/niri/spawn-at-startup-noctalia-5.kdl
        else
          ../../../../assets/config/niri/spawn-at-startup.kdl
      );
    };
    xdg.configFile."niri/window-rule.kdl" = {
      source = ../../../../assets/config/niri/window-rule.kdl;
    };
    xdg.configFile."niri/workspace.kdl" = {
      source = ../../../../assets/config/niri/workspace.kdl;
    };
    xdg.configFile."niri/extra.kdl" = {
      source = (
        if (desktop.type == "noctalia") then
          ../../../../assets/config/niri/extra-noctalia.kdl
        else
          ../../../../assets/config/niri/extra.kdl
      );
    };
  };
}
