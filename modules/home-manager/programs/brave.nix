{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.brave;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      brave
    ];

    xdg.mimeApps.defaultApplications = lib.mkIf (config.devlive.features.desktop.defaultWebBrowser == "brave") {
      "text/html" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";
    };
  };
}
