{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.brave;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      brave
    ];
  };
}
