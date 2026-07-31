{ lib, ... }:

{
  options.devlive.programs.zed-editor = {
    enable = lib.mkEnableOption "zed";
  };
}
