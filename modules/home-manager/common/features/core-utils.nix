{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.features.core-utils;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dig
      p7zip-rar
      tcpdump
      unzip
      wget
    ];

    programs.jq.enable = true;
    programs.starship.enable = true;

    devlive.programs.tmux.enable = true;
  };
}
