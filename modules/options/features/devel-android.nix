{
  lib,
  ...
}:

{
  options.devlive.features.devel-android = {
    enable = lib.mkEnableOption "devel-android";
  };
}
