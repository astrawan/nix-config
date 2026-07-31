{ lib, ... }:

{
  options.devlive.programs.lazygit = {
    enable = lib.mkEnableOption "lazygit";
  };
}
