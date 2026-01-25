{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.virtualisation.podman;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dive
      podman-compose
    ];
  };
}
