{ lib, ... }:

{
  options.devlive.programs.fragments = {
    enable = lib.mkEnableOption "fragments";
  };
}
