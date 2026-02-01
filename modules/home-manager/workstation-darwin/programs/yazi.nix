{ config, lib, ... }:

let
  cfg = config.devlive.programs.yazi;
in
{
  config = lib.mkIf (cfg.enable) {
    home.file.".config/yazi/flavors/tokyo-night.yazi".source = ./tokyo-night.yazi;
    programs.yazi.theme = {
      flavor = {
        dark = "tokyo-night";
        light = "tokyo-night";
      };
    };
  };
}
