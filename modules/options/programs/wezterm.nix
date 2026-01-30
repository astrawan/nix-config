{ config, lib, ... }:

let
  cfg = config.devlive.programs.wezterm;
in
{
  options.devlive.programs.wezterm = {
    enable = lib.mkEnableOption "wezterm";
    defaultTerminalEmulator = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    extraConfig = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };
}
