{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.devlive.programs.zed-editor;
in
{
  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "toml"
        "rust"
      ];
      userSettings = {
        agent = {
          dock = "right";
        };
        auto_update = false;
        buffer_font_family = "FiraCode Nerd Font Mono";
        buffer_font_size = 16;
        collaboration_panel = {
          dock = "right";
        };
        hour_format = "hour24";
        git_panel = {
          dock = "right";
        };
        # Tell Zed to use direnv and direnv can use a flake.nix environment
        load_direnv = "shell_hook";
        lsp = {
          rust-analyzer = {
            binary = {
              path_lookup = true;
            };
          };
          nix = {
            binary = {
              path_lookup = true;
            };
          };
        };
        outline_panel = {
          dock = "right";
        };
        project_panel = {
          dock = "right";
        };
        show_whitespaces = "all";
        terminal = {
          dock = "bottom";
          detect_venv = {
            on = {
              directories = [
                ".env"
                "env"
                ".venv"
                "vend"
              ];
              activate_script = "default";
            };
          };
          env = {
            TERM = "alacritty";
          };
          font_family = "FiraCode Nerd Font Mono";
          line_height = "comfortable";
          shell = {
            programs = "${pkgs.fish}/bin/fish";
          };
          toolbar = {
            title = true;
          };
          working_directory = "current_project_directory";
        };
        theme = {
          mode = "system";
          dark = "Ayu Dark";
          light = "Ayu Light";
        };
        ui_font_size = 16;
        vim_mode = true;
      };
    };
  };
}
