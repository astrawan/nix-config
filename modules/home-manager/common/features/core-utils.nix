{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.core-utils;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dig
      jaq
      p7zip-rar
      tcpdump
      unzip
      wget
    ];

    programs.starship.enable = true;

    devlive.programs.zellij.enable = true;
  };
}
