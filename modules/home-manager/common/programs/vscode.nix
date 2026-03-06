{ config, lib, ... }:

let
  cfg = config.devlive.programs.vscode;
in
{
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
    };
  };
}
