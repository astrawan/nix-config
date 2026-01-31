{ config, lib, ... }:

let
  cfg = config.devlive.programs.zen-browser;
in
{
  config = lib.mkIf (cfg.enable) {
    homebrew.casks = [
      "zen"
    ];
  };
}
