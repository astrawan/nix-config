{ lib, ... }:

{
  options.devlive.programs.brave = {
    enable = lib.mkEnableOption "brave";
  };
}
