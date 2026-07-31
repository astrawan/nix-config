{ lib, ... }:

{
  options.devlive.programs.discord = {
    enable = lib.mkEnableOption "discord";
  };
}
