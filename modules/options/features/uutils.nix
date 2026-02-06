{ config, lib, ... }:

let
  cfg = config.devlive.features.uutils;
in
{
  options.devlive.features.uutils = {
    enable = lib.mkEnableOption "uutils";
  };
}
