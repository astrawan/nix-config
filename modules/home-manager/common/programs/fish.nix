{ config, lib, ... }:

let
  cfg = config.devlive.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };
    home.shell.enableFishIntegration = true;
  };
}
