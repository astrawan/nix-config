{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.zen-browser;
in
{
  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
      profiles."default" = {
        containersForce = true;
        containers = {
          Personal = {
            color = "blue";
            icon = "fingerprint";
            id = 1;
          };
          Work = {
            color = "orange";
            icon = "briefcase";
            id = 2;
          };
          Banking = {
            color = "green";
            icon = "dollar";
            id = 3;
          };
          Shopping = {
            color = "pink";
            icon = "cart";
            id = 4;
          };
          "Dev-1" = {
            color = "red";
            icon = "circle";
            id = 5;
          };
          "Dev-2" = {
            color = "red";
            icon = "circle";
            id = 6;
          };
          "Dev-3" = {
            color = "red";
            icon = "circle";
            id = 7;
          };
          "Dev-4" = {
            color = "red";
            icon = "circle";
            id = 8;
          };
          "Dev-5" = {
            color = "red";
            icon = "circle";
            id = 9;
          };
        };
        settings = {
          "browser.startup.page" = 0;
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "browser.urlbar.placeholderName.private" = "DuckDuckGo";
          "sidebar.visibility" = "hide-sidebar";
          "zen.view.compact.enable-at-startup" = true;
          "zen.view.use-single-toolbar" = false;
          "zen.welcome-screen.seen" = true;
        };
      };
    };

    xdg.mimeApps.defaultApplications = lib.mkIf (config.devlive.features.desktop.defaultWebBrowser == "zen-browser") {
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";
    };
  };
}
