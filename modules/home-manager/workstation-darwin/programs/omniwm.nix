{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.devlive.programs.omniwm;
in
{
  config = lib.mkIf (cfg.enable) {
    home.packages = [
      pkgs.omniwm
    ];
  };
}
