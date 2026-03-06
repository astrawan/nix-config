{ config, lib, ... }:

let
  cfg = config.devlive.programs.vscode;
in
{
  options.devlive.programs.vscode = {
    enable = lib.mkEnableOption "vscode";
  };
}
