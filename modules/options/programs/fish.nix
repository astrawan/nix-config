{ lib, ... }:

{
  options.devlive.programs.fish = {
    enable = lib.mkEnableOption "fish";
    interactiveShellInit = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };
}
