{ lib, pkgs, ... }:

{
  options.devlive.host = {
    timeZone = lib.mkOption {
      type = lib.types.str;
    };
    defaultLocale = lib.mkOption {
      type = lib.types.str;
    };
    defaultShell = lib.mkOption {
      type = lib.types.package;
      default = pkgs.bash;
    };
    system = lib.mkOption {
      type = lib.types.enum [
        "darwin"
        "linux"
      ];
    };
    type = lib.mkOption {
      type = lib.types.enum [
        "lxc"
        "workstation"
        "wsl"
      ];
      default = "workstation";
    };
  };
}
