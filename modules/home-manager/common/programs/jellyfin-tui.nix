{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.jellyfin-tui;
  configDir =
    if pkgs.stdenv.hostPlatform.isDarwin && !config.xdg.enable then
      "Library/Application Support"
    else
      config.xdg.configHome;
  yamlFormat = pkgs.formats.yaml { };
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      jellyfin-tui
    ];

    home.file."${configDir}/jellyfin-tui/config.yaml" = {
      enable = cfg.settings != { };
      source = yamlFormat.generate "jellyfin-tui-config" cfg.settings;
    };
  };
}
