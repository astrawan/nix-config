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
        search = {
          force = true; # Needed for nix to overwrite search settings on rebuild
          default = "ddg"; # Aliased to duckduckgo, see other aliases in the link above
          engines = {
            nixos = {
              name = "NixOS Search";
              urls = [
                {
                  template = "https://search.nixos.org/packages?query={searchTerms}";
                  params = [
                    {
                      name = "query";
                      value = "searchTerms";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@snx"]; # Keep in mind that aliases defined here only work if they start with "@"
            };
            # My NixOS Option and package search shortcut
            mynixos = {
              name = "My NixOS";
              urls = [
                {
                  template = "https://mynixos.com/search?q={searchTerms}";
                  params = [
                    {
                      name = "query";
                      value = "searchTerms";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@mnx"]; # Keep in mind that aliases defined here only work if they start with "@"
            };
          };
        };
        settings = {
          "browser.startup.page" = 0;
          "privacy.userContext.newTabContainerOnLeftClick.enabled" = true;
          "sidebar.visibility" = "hide-sidebar";
          "zen.view.compact.enable-at-startup" = true;
          "zen.view.use-single-toolbar" = false;
          "zen.welcome-screen.seen" = true;
        };
      };
    };
  };
}
