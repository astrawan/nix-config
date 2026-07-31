{ lib, ... }:

{
  options.devlive.programs.helium = {
    enable = lib.mkEnableOption "helium";
  };
}
