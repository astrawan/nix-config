{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
  cfg = config.devlive.programs.wezterm;
in
{
  config = lib.mkIf cfg.enable {
    devlive.programs.wezterm.settings.window_background_opacity = lib.mkIf (desktop.type == "noctalia" && desktop.noctalia.compositor == "hyprland") 0.8;
  };

}
