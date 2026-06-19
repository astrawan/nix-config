{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.helium;
in
{
  config = lib.mkIf cfg.enable {
    programs.helium = {
      enable = true;
    };
  };
}
