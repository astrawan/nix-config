{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.uutils;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # uutils-acl
      uutils-coreutils-noprefix
      uutils-diffutils
      uutils-findutils
      # uutils-procps
      # uutils-sed
      # uutils-util-linux
    ];
  };
}
