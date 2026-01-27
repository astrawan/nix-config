{ config, lib, ... }:

let
  cfg = config.devlive.programs.fragments;
in
{
  options.devlive.programs.fragments = {
    enable = lib.mkEnableOption "fragments";
  };
}
