{ lib, ... }:

{
  options.devlive.host = {
    timeZone = lib.mkOption {
      type = lib.types.str;
    };
    defaultLocale = lib.mkOption {
      type = lib.types.str;
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
