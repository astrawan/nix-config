{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.devlive.features.devel-utils;
in
{
  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        inotify-tools
        dbx-desktop
      ]
      ++ (
        if config.devlive.features.desktop.type == "gnome" then
          with pkgs;
          [
            cartero
            gaphor
          ]
        else
          [ ]
      );
  };
}
