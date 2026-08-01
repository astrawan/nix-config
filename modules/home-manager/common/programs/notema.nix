{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.devlive.programs.notema;
  tomlFormat = pkgs.formats.toml { };
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      notema
    ];
    xdg.configFile = {
      "${pkgs.notema.pname}/identity.toml" = lib.mkIf (cfg.identity != { }) {
        source = tomlFormat.generate "notema-settings" cfg.identity;
      };
      "${pkgs.notema.pname}/config.toml" = lib.mkIf (cfg.settings != { }) {
        source = tomlFormat.generate "notema-settings" cfg.settings;
      };
    }
    // (lib.mapAttrs' (
      name: value:
      lib.nameValuePair "${pkgs.notema.pname}/themes/${name}.toml" {
        source = tomlFormat.generate "notema-settings" lib.mkMerge [
          value
          { schema_version = 1; }
        ];
      }
    ) cfg.themes);
  };
}
