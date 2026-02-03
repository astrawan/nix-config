{ config, lib, ... }:

let
  cfg = config.devlive.security.sudo-rs;
in
{
  config = lib.mkIf (cfg.enable) {
    security.sudo-rs = {
      enable = true;
    };
    security.sudo = {
      enable = false;
    };
  };
}
