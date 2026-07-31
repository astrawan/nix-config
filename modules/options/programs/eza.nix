{ lib, ... }:

{
  options.devlive.programs.eza = {
    enable = lib.mkEnableOption "eza";
  };
}
