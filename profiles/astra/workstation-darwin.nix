{ ... }:

{
  imports = [
    ./common.nix
    ./workstation-common.nix
  ];

  devlive.programs.wezterm = {
    enable = true;
    defaultTerminalEmulator = true;
  };
}
