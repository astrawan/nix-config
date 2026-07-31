{
  lib,
  ...
}:

{
  options.devlive.features.devel-utils = {
    enable = lib.mkEnableOption "devel-utils";
  };
}
