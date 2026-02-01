{ config, lib, ... }:

let
  cfg = config.devlive.programs.wezterm;
in
{
  config = lib.mkIf (cfg.enable) {
    devlive.programs.wezterm = lib.mkIf (config.devlive.programs.wezterm.enable) {
      settings = {
        macos_window_background_blur = 60;
        window_background_opacity = 0.7;
      };
    };
  };
}
