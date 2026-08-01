{
  config,
  lib,
  pkgs,
  ...
}:

let
  tomlFormat = pkgs.formats.toml { };
in
{
  options.devlive.programs.notema = {
    enable = lib.mkEnableOption "notema";
    identity = lib.mkOption rec {
      type = tomlFormat.type;
      apply = lib.mergeAttrs default;
      default = {
        schema_version = 1;
        device_name = "default";
      };
      example = lib.literalExpression ''
        {
          device_name = "";
          encrypted_keys = """
          -----BEGIN AGE ENCRYPTED FILE-----
          ...
          -----END AGE ENCRYPTED FILE-----
          """
        }
      '';
      description = ''
        Identity configuration written to
        {file}`$XDG_CONFIG_HOME/${pkgs.notema.pname}/identity.toml`.
      '';
    };
    settings = lib.mkOption rec {
      type = tomlFormat.type;
      apply = lib.mergeAttrs default;
      default = {
        schema_version = 1;
        attachments = {
          download_remote_images = true;
        };
        editor = {
          start_fullscreen = false;
        };
        journal = {
          path = "${config.home.homeDirectory}/Journals";
        };
        location = {
          use_location_timezone = true;
        };
        ui = {
          color_mode = "auto";
          chrome = "default";
          ignore_journal_themes = false;
          layout = {
            editor = {
              body_center_vertically = false;
            };
            reader = {
              body_center_vertically = true;
              body_max_width = 100;
              body_max_top_padding = 6;
              show_link_urls = false;
            };
          };
          theme = "journal";
        };
      };
      example = lib.literalExpression ''
        {
          journal = {
            path = "/path/to/journals";
          };
          ui = {
            theme = "journal";
            color_mode = "auto";
            chrome = "default";
            ignore_journal_themes = false;
          };
          editor = {
            start_fullscreen = false;
          };
          location = {
            use_location_timezone = true;
          };
        }
      '';
      description = ''
        Configuration written to
        {file}`$XDG_CONFIG_HOME/${pkgs.notema.pname}/config.toml`.

        See <https://github.com/paviro/Notema/blob/main/src/config/mod.rs>
        foro the full list of options.
      '';
    };
    themes = lib.mkOption {
      type = with lib.types; attrsOf tomlFormat.type;
      default = { };
      example = lib.literalExpression ''
        {
          custom = {
            chrome = {
              default_style = "flat";
              script = 0.45;
            };
            surfaces = {
              base = {
                dark = "#a0a0a0";
                light = "#fcfcfc";
              };
              content = {
                dark = "#141414";
                light = "#f3f3f3";
              };
              dialog = {
                dark = "#191919";
                light = "#eeeeee";
              };
              raised = {
                dark = "#1e1e1e";
                light = "#e9e9e9";
              };
            };
          };
        }
      '';
      description = ''
        Theme configurations written to
        {file}`$XDG_CONFIG_HOME/${pkgs.notema.pname}/themes/theme.toml`.
      '';
    };
  };
}
