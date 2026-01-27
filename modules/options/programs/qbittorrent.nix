{ config, lib, ... }:

let
  cfg = config.devlive.programs.qbittorrent;
in
{
  options.devlive.programs.qbittorrent = {
    enable = lib.mkEnableOption "qbittorrent";
  };
}
