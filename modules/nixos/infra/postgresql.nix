{ config, lib, ... }:

let
  cfg = config.devlive.infra.postgresql;
in
{
  config = lib.mkIf (cfg.enable) {
  };
}
