{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
  cfg = config.devlive.programs.hyprland;
in
{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        source = [
          "${config.xdg.configHome}/hypr/autostart.conf"
          "${config.xdg.configHome}/hypr/binds.conf"
          "${config.xdg.configHome}/hypr/common.conf"
          "${config.xdg.configHome}/hypr/env.conf"
          "${config.xdg.configHome}/hypr/input.conf"
          "${config.xdg.configHome}/hypr/laf.conf"
          "${config.xdg.configHome}/hypr/permissions.conf"
          "${config.xdg.configHome}/hypr/rules.conf"
        ]
        ++(if desktop.type == "noctalia" then [ "${config.xdg.configHome}/hypr/noctalia/noctalia-colors.conf" ] else [])
        ++(if config.programs.ghostty.enable then [ "${config.xdg.configHome}/hypr/rules-ghostty.conf" ] else [])
        ++(if config.programs.wezterm.enable then [ "${config.xdg.configHome}/hypr/rules-wezterm.conf" ] else []);
      };
    };

    xdg.configFile."hypr/autostart.conf" = {
      source = ../../../../assets/config/hypr/autostart.conf;
    };
    xdg.configFile."hypr/binds.conf" = {
      source = ../../../../assets/config/hypr/binds.conf;
    };
    xdg.configFile."hypr/common.conf" = {
      source = ../../../../assets/config/hypr/common.conf;
    };
    xdg.configFile."hypr/env.conf" = {
      source = ../../../../assets/config/hypr/env.conf;
    };
    xdg.configFile."hypr/input.conf" = {
      source = ../../../../assets/config/hypr/input.conf;
    };
    xdg.configFile."hypr/laf.conf" = {
      source = ../../../../assets/config/hypr/laf.conf;
    };
    xdg.configFile."hypr/permissions.conf" = {
      source = ../../../../assets/config/hypr/permissions.conf;
    };
    xdg.configFile."hypr/rules.conf" = {
      source = ../../../../assets/config/hypr/rules.conf;
    };
    xdg.configFile."hypr/rules-ghostty.conf" = lib.mkIf (config.programs.ghostty.enable) {
      source = ../../../../assets/config/hypr/rules-ghostty.conf;
    };
    xdg.configFile."hypr/rules-wezterm.conf" = lib.mkIf (config.programs.wezterm.enable) {
      source = ../../../../assets/config/hypr/rules-wezterm.conf;
    };


  };
}
