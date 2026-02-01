{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.zen-browser;
in
{
  config = lib.mkIf cfg.enable {
    xdg.mimeApps.defaultApplications = lib.mkIf (config.devlive.features.desktop.defaultWebBrowser == "zen-browser") {
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";
    };
  };
}
