{ lib, ... }:

{
  options.devlive.programs.zen-browser = {
    enable = lib.mkEnableOption "zen-browser";
  };
}
