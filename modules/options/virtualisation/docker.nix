{ config, lib, ... }:

let
  cfg = config.devlive.virtualisation.docker;
in
{
  options.devlive.virtualisation.docker = {
    enable = lib.mkEnableOption "docker";
  };
}
