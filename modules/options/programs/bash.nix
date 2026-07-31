{ lib, ... }:

{
  options.devlive.programs.bash = {
    enable = lib.mkEnableOption "bash";
  };
}
