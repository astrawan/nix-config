{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
  cfg = config.devlive.programs.ghostty;
in
{
  config = lib.mkIf cfg.enable {
    programs.ghostty.enable = true;
    programs.ghostty.settings = {
      font-family = "FiraCode Nerd Font Mono";
      font-style = "SemiBold";
      font-size = 12;
      term = "xterm-256color";
      window-padding-x = 8;
    };

    programs.ghostty.settings.background-opacity = lib.mkIf (desktop.type == "noctalia" && desktop.noctalia.compositor == "hyprland") 0.8;
    programs.ghostty.settings.theme = lib.mkIf (desktop.type == "noctalia") "noctalia";

    devlive.features.desktop.defaultTerminalEmulator = lib.mkIf (cfg.defaultTerminalEmulator) pkgs.ghostty;
  };
}
