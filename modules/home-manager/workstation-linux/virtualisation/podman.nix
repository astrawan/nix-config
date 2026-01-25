{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.virtualisation.podman;
in
{
  imports = [
    ../../common/virtualisation/podman.nix
  ];

  config = lib.mkIf cfg.enable {
    home.packages = (
      if config.devlive.features.desktop.type != null then
        with pkgs; [
          distrobox
        ]
      else
        []
    )
    ++ (
      if config.devlive.features.desktop.type == "gnome" then
        with pkgs; [
          boxbuddy
          pods
        ]
      else
        []
    );
  };
}
