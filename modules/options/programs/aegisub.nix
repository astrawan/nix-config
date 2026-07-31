{ lib, ... }:

{
  options.devlive.programs.aegisub = {
    enable = lib.mkEnableOption "aegisub";
  };
}
