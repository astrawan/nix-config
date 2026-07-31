{ lib, ... }:

{
  options.devlive.programs.omniwm = {
    enable = lib.mkEnableOption "omniwm";
  };
}
