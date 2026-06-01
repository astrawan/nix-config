{ config, lib, ... }:

let
  cfg = config.devlive.programs.helium;
in
{
  options.devlive.programs.helium = {
    enable = lib.mkEnableOption "helium";
  };
}
