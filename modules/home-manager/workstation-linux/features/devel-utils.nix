{ config, lib, pkgs, ... }:

let 
  cfg = config.devlive.features.devel-utils;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      inotify-tools
    ]
    ++ (
      if config.devlive.features.desktop.type == "gnome" then
        with pkgs; [cartero gaphor]
      else
        []
    )
    ++ (
      if config.devlive.features.desktop.type != null then
        with pkgs; [dbeaver-bin]
      else
        []
    );
  };
}
