{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.devlive.virtualisation.docker;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dive
    ];
  };
}
