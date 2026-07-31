{ lib, ... }:

{
  options.devlive.programs.vscode = {
    enable = lib.mkEnableOption "vscode";
  };
}
