{ lib, ... }:

{
  options.devlive.programs.dbx-desktop = {
    enable = lib.mkEnableOption "dbx-desktop";
  };
}
