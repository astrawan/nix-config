{ lib, ... }:

{
  options.devlive.services.xwayland-satellite = {
    enable = lib.mkEnableOption "xwayland-satellite";
  };
}
