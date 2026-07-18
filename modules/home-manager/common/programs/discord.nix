{ config, lib, ... }:

let
  cfg = config.devlive.programs.discord;
in
{
  config = lib.mkIf cfg.enable {
    programs.discord = {
      enable = true;
    };
  };
}
