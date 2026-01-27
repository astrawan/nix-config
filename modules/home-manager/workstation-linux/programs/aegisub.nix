{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.aegisub;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      aegisub
    ];
    programs.yazi.settings.opener.aegisub = lib.mkIf(config.programs.yazi.enable) [
      {
          run = ''aegisub "$@"'';
          orphan = true;
      }
    ];
    programs.yazi.settings.open.rules = lib.mkIf(config.programs.yazi.enable) [
      {
        mime = "application/subrip";
        use = "aegisub";
      }
    ];
    xdg.mimeApps.defaultApplications."application/x-subrip" = "org.aegisub.Aegisub.desktop";
  };
}
