{ lib, ... }:

{
  options.devlive.virtualisation.podman = {
    enable = lib.mkEnableOption "podman";
  };
}
