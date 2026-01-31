{ config, lib, ... }:

let
  cfg = config.devlive.programs.zathura;
in
{
  options.devlive.programs.zathura = {
    enable = lib.mkEnableOption "zathura";
  };
}
