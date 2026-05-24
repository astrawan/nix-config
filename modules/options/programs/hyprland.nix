{ config, lib, ... }:

let
  cfg = config.devlive.programs.hyprland;
in
{
  options.devlive.programs.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };
}
