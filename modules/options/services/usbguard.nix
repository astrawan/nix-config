{ lib, ... }:

{
  options.devlive.services.usbguard = {
    enable = lib.mkEnableOption "usbguard";
  };
}
