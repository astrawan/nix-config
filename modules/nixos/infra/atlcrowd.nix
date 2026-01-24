{ config, lib, ... }:

let
  cfg = config.devlive.infra.atlcrowd;
in
{
  config = lib.mkIf (cfg.enable) {
  };
}
