{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.jellyfin-tui;
  yamlFormat = pkgs.formats.yaml { };
in
{
  options.devlive.programs.jellyfin-tui = {
    enable = lib.mkEnableOption "jellyfin-tui";
    settings = lib.mkOption {
      type = yamlFormat.type;
      default = { };
      defaultText = lib.literalExpression "{ }";
      example = lib.literalExpression ''
        {
          servers = [
            {
              name = "your server name";
              password = "your password";
              url = "https://your.jellyfin.host";
              username = "your username";
            }
          ];
        }
      '';
      description = ''
        Configuration written to
        {file}`$XDG_CONFIG_HOME/jellyfin-tui/config.yaml`
        on Linux or on Darwin if [](#opt-xdg.enable) is set, otherwise
        {file}`~/Library/Application Support/jellyfin-tui/config.yaml`.
        See
        <https://github.com/dhonus/jellyfin-tui#configuration> for supported values.
      '';
    };
  };
}
