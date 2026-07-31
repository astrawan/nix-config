{ lib, ... }:

{
  options.devlive.programs.librewolf = {
    enable = lib.mkEnableOption "librewolf";
  };
}
