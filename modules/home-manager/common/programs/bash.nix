{ config, lib, ... }:

let 
  cfg = config.devlive.programs.bash;
in
{
  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
    };
    home.shell.enableBashIntegration = true;
  };
}
