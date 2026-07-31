{ lib, ... }:

{
  options.devlive.programs.zellij = {
    enable = lib.mkEnableOption "zellij";
  };
}
