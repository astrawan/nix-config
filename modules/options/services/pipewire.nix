{ lib, ... }:

{
  options.devlive.services.pipewire = {
    enable = lib.mkEnableOption "pipewire";
  };
}
