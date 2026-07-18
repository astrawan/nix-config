{ config, lib, ... }:

let
  cfg = config.devlive.programs.discord;
in
{
  options.devlive.programs.discord = {
    enable = lib.mkEnableOption "discord";
  };
}
