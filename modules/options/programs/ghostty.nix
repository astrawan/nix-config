{ config, lib, ... }:

let
  cfg = config.devlive.programs.ghostty;
in
{
  options.devlive.programs.ghostty = {
    enable = lib.mkEnableOption "ghostty";
    defaultTerminalEmulator = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
}
