{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.devel-utils;
in
{
  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      orbstack
    ];
  };
}
