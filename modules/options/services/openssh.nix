{ lib, ... }:

{
  options.devlive.services.openssh = {
    enable = lib.mkEnableOption "openssh";
  };
}
