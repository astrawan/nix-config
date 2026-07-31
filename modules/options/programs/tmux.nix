{ lib, ... }:

{
  options.devlive.programs.tmux = {
    enable = lib.mkEnableOption "tmux";
  };
}
