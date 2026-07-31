{ lib, ... }:

{
  options.devlive.programs.notema = {
    enable = lib.mkEnableOption "notema";
  };
}
