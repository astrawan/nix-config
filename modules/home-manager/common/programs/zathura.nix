{ config, lib, ... }:

let
  cfg = config.devlive.programs.zathura;
in
{
  config = lib.mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      options = {
        selection-clipboard = "clipboard";
      };
      extraConfig = lib.mkIf (config.devlive.features.desktop.type == "noctalia") ''
        include noctaliarc
      '';
    };
  };
}
