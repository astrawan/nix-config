{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.qbittorrent;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      qbittorrent
    ];
    programs.yazi.settings.opener.qbittorrent = lib.mkIf(config.programs.yazi.enable) [
      {
          run = ''qbittorrent "$@"'';
          orphan = true;
      }
    ];
    programs.yazi.settings.open.rules = lib.mkIf(config.programs.yazi.enable) [
      {
        mime = "application/bittorrent";
        use = "qbittorrent";
      }
    ];
    xdg.mimeApps.defaultApplications."application/x-bittorrent" = "org.qbittorrent.qBittorrent.desktop";
  };
}
