{ config, lib, pkgs, ... }:
{
  fonts = lib.mkIf (config.devlive.features.desktop != null) {
    fontDir.enable = true;
    packages = with pkgs; [
      adwaita-fonts
      dejavu_fonts
      nerd-fonts.fira-code
    ];
  };
}
