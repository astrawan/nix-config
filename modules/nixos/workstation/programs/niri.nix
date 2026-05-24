{ config, lib, ... }:

let
  cfg = config.devlive.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
  };
}
