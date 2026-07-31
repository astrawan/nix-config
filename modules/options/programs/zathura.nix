{ lib, ... }:

{
  options.devlive.programs.zathura = {
    enable = lib.mkEnableOption "zathura";
  };
}
