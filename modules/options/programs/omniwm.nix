{ config, lib, ... }:

let
  cfg = config.devlive.programs.omniwm;
in
{
  options.devlive.programs.omniwm = {
    enable = lib.mkEnableOption "omniwm";
  };
}
