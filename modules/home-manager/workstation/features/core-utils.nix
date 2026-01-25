{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.core-utils;
in
{
  imports = [
    ../../common/features/core-utils.nix
  ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ffmpeg
      pciutils
    ];

    programs.starship.enable = true;
  };
}
