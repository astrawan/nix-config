{ lib, ... }:

{
  options.devlive.virtualisation.libvirtd = {
    enable = lib.mkEnableOption "libvirtd";
  };
}
