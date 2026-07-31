{ lib, ... }:

{
  options.devlive.programs.niri = {
    enable = lib.mkEnableOption "niri";
  };
}
