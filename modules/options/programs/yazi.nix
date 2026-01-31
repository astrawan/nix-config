{ config, lib, ... }:

let
  cfg = config.devlive.programs.yazi;
in
{
  options.devlive.programs.yazi = {
    enable = lib.mkEnableOption "yazi";
    extraPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
    };
    plugins = lib.mkOption {
      type = with lib.types; attrsOf (oneOf [
        path
        package
      ]);
      default = { };
    };
  };
}
