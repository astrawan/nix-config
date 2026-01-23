{ config, lib, ... }:

{
  options.devlive.features.desktop = {
    type = lib.mkOption {
      type = lib.types.enum [
        "gnome"
        "noctalia"
      ];
      default = "gnome";
      description = "Default desktop to use";
      example = "gnome";
    };
    defaultWebBrowser = lib.mkOption {
      type = lib.types.enum [
        "brave"
        "librewolf"
        "zen-browser"
      ];
      default = "zen-browser";
      description = "Default Web Browser";
      example = "zen-browser";
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
        Extra packages to make avaiable to desktop
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
        Extra packages to make avaiable to desktop via home-manager
      '';
    };
  };
}
