{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.fragments;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      fragments
    ];
    programs.yazi.settings.opener.fragments = lib.mkIf(config.programs.yazi.enable) [
      {
          run = ''fragments "$@"'';
          orphan = true;
      }
    ];
    programs.yazi.settings.open.rules = lib.mkIf(config.programs.yazi.enable) [
      {
        mime = "application/bittorrent";
        use = "fragments";
      }
    ];
    xdg.mimeApps.defaultApplications."application/x-bittorrent" = "de.haeckerfelix.Fragments.desktop";
  };
}
