{ lib, ... }:

{
  options.devlive.programs.keystore-explorer = {
    enable = lib.mkEnableOption "keystore-explorer";
  };
}
