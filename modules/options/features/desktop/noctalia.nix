{ config, lib, ... }:

{
  options.devlive.features.desktop.noctalia = {
    compositor = lib.mkOption {
      type = lib.types.enum [
        "hyprland"
        "niri"
      ];
      default = "hyprland";
      description = "Compositor to use with noctalia";
      example = "hyprland";
    };
    extraPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      example = lib.lieteralExpression ''
        with pkgs; [
          imv
          mpv
          yazi
        ]
      '';
      description = ''
        Extra packages to make avaiable to noctalia
      '';
    };
    extraHomePackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      example = lib.lieteralExpression ''
        with pkgs; [
          imv
          mpv
          yazi
        ]
      '';
      description = ''
        Extra packages to make avaiable to noctalia via home-manager
      '';
    };
    wallpaperRolling = {
      enable = lib.mkEnableOption "wallpaper-rolling";
      day = {
        time = lib.mkOption {
          type = lib.types.str;
          default = "06:00:00";
        };
        image = lib.mkOption {
          type = lib.types.path;
          default = ../../../../assets/wallpapers/wallhaven_1pqq1w.jpg;
        };
      };
      night = {
        time = lib.mkOption {
          type = lib.types.str;
          default = "18:00:00";
        };
        image = lib.mkOption {
          type = lib.types.path;
          default = ../../../../assets/wallpapers/wallhaven_9doozw.jpg;
        };
      };
    };
  };
}
