{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.devlive.programs.notema;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      notema
    ];
  };
}
