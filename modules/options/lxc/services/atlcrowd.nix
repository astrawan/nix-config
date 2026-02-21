{ lib, pkgs, ... }:

{
  options.devlive.lxc.services.atlcrowd = {
    enable = lib.mkEnableOption "atlcrowd";
    user = lib.mkOption {
      type = lib.types.str;
      default = "atlcrowd";
    };
    group = lib.mkOption {
      type = lib.types.str;
      default = "atlcrowd";
    };
    extraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "group" ];
    };
    baseDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/atlcrowd";
    };
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/atlassian/application-data/crowd";
    };
    extraEnvironment = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "ENVIRONMENT=production" ];
    };
    javaOpts = lib.mkOption {
      type = lib.types.either (lib.types.listOf lib.types.str) lib.types.str;
      default = "";
    };
    catalinaOpts = lib.mkOption {
      type = lib.types.either (lib.types.listOf lib.types.str) lib.types.str;
      default = "";
    };

    jdk = lib.mkPackageOption pkgs "jdk" { };
  };
}
