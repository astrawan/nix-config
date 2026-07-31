{ lib, ... }:

{
  options.devlive.services.tailscale = {
    enable = lib.mkEnableOption "tailscale";
  };
}
