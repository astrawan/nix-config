{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.yazi;
in
{
  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      extraPackages = with pkgs; [
        # recycle-bin
        trash-cli
      ] ++cfg.extraPackages;
      initLua = ''
        ${if (builtins.hasAttr "full-border" config.programs.yazi.plugins) then ''
          require("full-border"):setup({
            type = ui.Border.ROUNDED,
          })
        '' else ""}
        ${if (builtins.hasAttr "gvfs" cfg.plugins) then ''
          require("gvfs"):setup({})
        '' else ""}
        ${if (builtins.hasAttr "recycle-bin" config.programs.yazi.plugins) then ''
          require("recycle-bin"):setup({})
        '' else ""}
      '';
      keymap = {
        mgr.prepend_keymap = [
          {
            run = ''shell "$SHELL" --block'';
            on = [ "!" ];
            desc = "Open $SHELL here";
          }
        ]
        ++(if (builtins.hasAttr "chmod" config.programs.yazi.plugins) then [
          {
            run = "plugin chmod";
            on = [ ">" "c" ];
            desc = "Chmod on selected files";
          }
        ] else [ ])
        ++(if (builtins.hasAttr "gvfs" cfg.plugins) then [
          {
            run = "plugin gvfs -- add-mount";
            on = [ "<C-g>" "a" ];
            desc = "Add a GVFS mount URI";
          }
          {
            run = "plugin gvfs -- jump-back-prev-cwd";
            on = [ "<C-g>" "b" ];
            desc = "Jump back to position before jumped to device";
          }
          {
            run = "plugin gvfs -- automount-when-cd";
            on = [ "<C-g>" "c" ];
            desc = "Enable automount when cd to device under cwd";
          }
          {
            run = "plugin gvfs -- automount-when-cd --disabled";
            on = [ "<C-g>" "C" ];
            desc = "Disable automount when cd to device under cwd";
          }
          {
            run = "plugin gvfs -- edit-mount";
            on = [ "<C-g>" "e" ];
            desc = "Edit a GVFS mount URI";
          }
          {
            run = "plugin gvfs -- jump-to-device";
            on = [ "<C-g>" "j" ];
            desc = "Select device then jump to its mount point";
          }
          {
            run = "plugin gvfs -- jump-to-device --automount";
            on = [ "<C-g>" "J" ];
            desc = "Automount than select device to jump to its mount point";
          }
          {
            run = "plugin gvfs -- select-then-mount";
            on = [ "<C-g>M" "m" ];
            desc = "Select device then mount";
          }
          {
            run = "plugin gvfs -- select-then-mount --jump";
            on = [ "<C-g>" "M" ];
            desc = "Select device to mount and jump to its mount point";
          }
          {
            run = "plugin gvfs -- remove-mount";
            on = [ "<C-g>" "r" ];
            desc = "Remove a GVFS mount URI";
          }
          {
            run = "plugin gvfs -- remount-current-cwd-device";
            on = [ "<C-g>" "R" ];
            desc = "Remount device under cwd";
          }
          {
            run = "plugin gvfs -- select-then-unmount --eject";
            on = [ "<C-g>" "u" ];
            desc = "Select device than unmount";
          }
          {
            run = "plugin gvfs -- select-then-unmount --eject --force";
            on = [ "<C-g>" "U" ];
            desc = "Select device than force to unmount";
          }
        ] else [ ])
        ++(if (builtins.hasAttr "mount" config.programs.yazi.plugins) then [
          {
            run = "plugin mount";
            on = [ ">" "m" ];
            desc = "Mount/unmount disk";
          }
        ] else [ ])
        ++(if (builtins.hasAttr "recycle-bin" config.programs.yazi.plugins) then [
          {
            run = "plugin recycle-bin";
            on = [ ">" "r" ];
            desc = "Open Recycle Bin menu";
          }
        ] else [ ])
        ++(if (builtins.hasAttr "toggle-pane" config.programs.yazi.plugins) then [
          {
            run = "plugin toggle-pane max-preview";
            on = [ "P" ];
            desc = "How or hide the preview pane";
          }
        ] else [ ]);
      };
      plugins = {
        chmod = pkgs.yaziPlugins.chmod;
        full-border = pkgs.yaziPlugins.full-border;
        toggle-pane = pkgs.yaziPlugins.toggle-pane;
      } // cfg.plugins;
      settings = {
        opener = {
          default = [
            {
              run = ''xdg-open "$@"'';
              orphan = true;
            }
          ];
          imv = lib.mkIf(config.programs.imv.enable) ([
            {
              run = ''imv "$@"'';
              orphan = true;
            }
          ]);
          zathura = lib.mkIf(config.programs.zathura.enable) ([
            {
              run = ''zathura "$@"'';
              orphan = true;
            }
          ]);
          mpv = lib.mkIf(config.programs.mpv.enable) ([
            {
              run = ''mpv "$@"'';
              orphan = true;
            }
          ]);
        };
        open = {
          rules = (if (config.programs.zathura.enable) then
            [
              {
                mime = "application/pdf";
                use = "zathura";
              }
              {
                mime = "application/postscript";
                use = "zathura";
              }
              {
                mime = "image/djvu";
                use = "zathura";
              }
            ]
          else [])
          ++(if (config.programs.imv.enable) then
            [
              {
                mime = "image/bmp";
                use = "imv";
              }
              {
                mime = "image/gif";
                use = "imv";
              }
              {
                mime = "image/jpeg";
                use = "imv";
              }
              {
                mime = "image/jpg";
                use = "imv";
              }
              {
                mime = "image/pjpeg";
                use = "imv";
              }
              {
                mime = "image/png";
                use = "imv";
              }
              {
                mime = "image/tiff";
                use = "imv";
              }
              {
                mime = "image/webp";
                use = "imv";
              }
              {
                mime = "image/x-*";
                use = "imv";
              }
              {
                mime = "image/heic";
                use = "imv";
              }
            ]
          else [])
          ++(if (config.programs.mpv.enable) then
            [
              {
                mime = "video/*";
                use = "mpv";
              }
            ]
          else [])
          ++(
            [
              {
                mime = "*";
                use = "default";
              }
            ]
          );
        };
        mgr.ratio = [3 5 0];
      };
    };
  };
}
