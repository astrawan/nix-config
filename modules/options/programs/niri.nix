{ config, lib, ... }:

let
  cfg = config.devlive.programs.niri;
in
{
  options.devlive.programs.niri = {
    enable = lib.mkEnableOption "niri";
  };
}
