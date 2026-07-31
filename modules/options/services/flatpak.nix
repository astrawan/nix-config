{
  lib,
  ...
}:

{
  options.devlive.services.flatpak = {
    enable = lib.mkEnableOption "flatpak";
  };
}
