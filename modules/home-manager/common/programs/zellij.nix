{ config, lib, ... }:

let
  cfg = config.devlive.programs.zellij;
in
{
  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
    };
  };
}
