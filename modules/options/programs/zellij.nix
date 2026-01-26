{ config, lib, ... }:

let
  cfg = config.devlive.programs.zellij;
in
{
  options.devlive.programs.zellij = {
    enable = lib.mkEnableOption "zellij";
  };
}
