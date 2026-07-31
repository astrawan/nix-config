{ lib, ... }:

{
  options.devlive.virtualisation.docker = {
    enable = lib.mkEnableOption "docker";
  };
}
