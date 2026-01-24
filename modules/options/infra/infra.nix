{ lib, ... }:

{
  options.devlive.infra = {
    jdkPackage = lib.mkOption {
      type = lib.types.package;
    };
    gitPackage = lib.mkOption {
      type = lib.types.package;
    };
    domain = lib.mkOption {
      type = lib.types.str;
      default = "stack.devlive.cloud";
    };
  };
}
