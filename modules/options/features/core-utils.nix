{
  lib,
  ...
}:

{
  options.devlive.features.core-utils = {
    enable = lib.mkEnableOption "core-utils";
  };
}
