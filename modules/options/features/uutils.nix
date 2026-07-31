{ lib, ... }:

{
  options.devlive.features.uutils = {
    enable = lib.mkEnableOption "uutils";
  };
}
