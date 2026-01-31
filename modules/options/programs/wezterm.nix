{ config, lib, ... }:

let
  cfg = config.devlive.programs.wezterm;
  settings = {
    options = {
      macos_window_background_blur = lib.mkOption {
        type = lib.types.int;
        default = 0;
      };
      window_background_opacity = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
      };
    };
  };
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
    settings = lib.mkOption {
      type = lib.types.submodule settings;
      default = {
        macos_window_background_blur = 0;
        window_background_opacity = 1.0;
      };
    };
  };
}
