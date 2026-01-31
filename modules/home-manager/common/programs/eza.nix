{ config, lib, ... }:

let 
  cfg = config.devlive.programs.eza;
in
{
  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      colors = "always";
      enableBashIntegration = lib.mkIf (config.devlive.programs.bash.enable) true;
      enableFishIntegration = lib.mkIf (config.devlive.programs.fish.enable) true;
      icons = "always";
    };
  };
}
