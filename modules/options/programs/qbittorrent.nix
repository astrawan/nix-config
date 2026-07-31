{ lib, ... }:

{
  options.devlive.programs.qbittorrent = {
    enable = lib.mkEnableOption "qbittorrent";
  };
}
