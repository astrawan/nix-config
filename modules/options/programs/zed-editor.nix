{ config, lib, ... }:

let
  cfg = config.devlive.programs.zed-editor;
in
{
  options.devlive.programs.zed-editor = {
    enable = lib.mkEnableOption "zed";
  };
}

