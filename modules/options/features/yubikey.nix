{
  lib,
  ...
}:

{
  options.devlive.features.yubikey = {
    enable = lib.mkEnableOption "yubikey";
  };
}
