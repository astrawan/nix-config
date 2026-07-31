{ lib, ... }:

{
  options.devlive.features.desktop.gnome = {
    extraPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      example = lib.lieteralExpression ''
        with pkgs; [
          lazygit
          wireshark
        ]
      '';
      description = ''
        Extra packages to make avaiable to gnome
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
        Extra packages to make avaiable to gnome via home-manager
      '';
    };
  };
}
