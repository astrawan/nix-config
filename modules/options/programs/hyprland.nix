{ lib, ... }:

{
  options.devlive.programs.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };
}
