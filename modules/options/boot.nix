{ lib, ... }:

{
  options.devlive.boot = {
    plymouth = {
      enable = lib.mkEnableOption "plymouth";
      default = false;
    };
  };
}
