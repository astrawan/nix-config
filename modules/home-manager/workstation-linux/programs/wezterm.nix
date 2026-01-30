{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.wezterm;
in
{
  config = lib.mkIf cfg.enable {
    programs.wezterm.enable = true;
    programs.wezterm.extraConfig = ''
      local config = wezterm.config_builder()

      config.font = wezterm.font("FiraCode Nerd Font Mono", {weight="Medium", stretch="Normal", style="Normal"})
      config.enable_tab_bar = false

      ${cfg.extraConfig}

      ${if config.devlive.features.desktop.type == "noctalia" then ''config.color_scheme = "Noctalia"'' else ""}
      return config
    '';
    devlive.features.desktop.defaultTerminalEmulator = lib.mkIf (cfg.defaultTerminalEmulator) pkgs.wezterm;
  };
}
