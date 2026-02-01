{ config, lib, ... }:

let
  cfg = config.devlive.services.tailscale;
in
{
  config = lib.mkIf (cfg.enable) {
    homebrew.casks = [
      "tailscale-app"
    ];
  };
}
