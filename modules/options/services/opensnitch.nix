{ lib, ... }:

{
  options.devlive.services.opensnitch = {
    enable = lib.mkEnableOption "opensnitch";
  };
}
