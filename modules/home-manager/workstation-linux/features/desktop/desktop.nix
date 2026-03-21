{ config, lib, ... }:

let
  cfg = config.devlive.features.desktop;
in
{
  config = {
    home.file = {
      "${config.home.homeDirectory}/.local/bin/devlive-desktop-terminal".source = "${config.devlive.features.desktop.defaultTerminalEmulator}/bin/${config.devlive.features.desktop.defaultTerminalEmulator.meta.mainProgram}";
    };
    home.sessionPath = [ "$HOME/.local/bin" ];

    programs.zapzap = lib.mkIf(cfg.enableWhatsApp) {
      enable = true;
      settings = {
        notification = {
          donation_message = false;
        };
        system = {
          theme = "dark";
          tray_theme = "symbolic_light";
          wayland = true;
        };
        website = {
          open_page = false;
        };
      };
    };
  };
}
