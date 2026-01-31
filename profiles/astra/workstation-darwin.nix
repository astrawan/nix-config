{ ... }:

{
  imports = [
    ./common.nix
  ];

  devlive.programs.wezterm = {
    enable = true;
    defaultTerminalEmulator = true;
  };
}
