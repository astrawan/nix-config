{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.gnupg;
in
{
  config = lib.mkIf (cfg.enable) {
    services.gpg-agent.pinentry.program = pkgs.pinentry_mac;
  };
}
