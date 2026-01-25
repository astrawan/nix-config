{ config, lib, pkgs, ... }:

let 
  cfg = config.devlive.features.devel-utils;
in
{
  imports = [
    ../../common/features/devel-utils.nix
  ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      inotify-tools
    ]
    ++ (
      if config.devlive.features.desktop.type == "gnome" then
        with pkgs; [cartero dbeaver-bin gaphor]
      else
        []
    );
  };
}
