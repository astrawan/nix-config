{ config, lib, ... }:

let
  cfg = config.devlive.programs.eza;
in
{
  options.devlive.programs.eza = {
    enable = lib.mkEnableOption "eza";
  };
}
