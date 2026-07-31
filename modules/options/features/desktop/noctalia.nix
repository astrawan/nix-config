{
  lib,
  pkgs,
  ...
}:

{
  options.devlive.features.desktop.noctalia = {
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.noctalia-shell;
    };
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
  };
}
