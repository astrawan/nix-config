{ config, ... }:
{
  config = {
    home.file = {
      "${config.home.homeDirectory}/.local/bin/devlive-desktop-terminal".source = "${config.devlive.features.desktop.defaultTerminalEmulator}/bin/${config.devlive.features.desktop.defaultTerminalEmulator.meta.mainProgram}";
    };
    home.sessionPath = [ "$HOME/.local/bin" ];
  };
}
