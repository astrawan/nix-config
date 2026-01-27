{ config, lib, ... }:

let
  cfg = config.devlive.programs.aegisub;
in
{
  options.devlive.programs.aegisub = {
    enable = lib.mkEnableOption "aegisub";
  };
}
