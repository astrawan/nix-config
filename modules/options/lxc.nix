{ lib, ... }:

{
  options.devlive.lxc = {
    enable = lib.mkEnableOption "lxc";
  };
}
