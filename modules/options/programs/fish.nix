{ config, lib, ... }:

let
  cfg = config.devlive.programs.fish;
in
{
  options.devlive.programs.fish = {
    enable = lib.mkEnableOption "fish";
  };
}
