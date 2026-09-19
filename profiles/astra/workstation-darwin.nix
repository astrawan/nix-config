{ ... }:

{
  imports = [
    ./common.nix
    ./workstation-common.nix
  ];

  devlive.programs.qbittorrent.enable = true;
  devlive.programs.wezterm = {
    enable = true;
    defaultTerminalEmulator = true;
  };
}
