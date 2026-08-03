{
  config,
  lib,
  pkgs,
  ...
}:

let
  desktop = config.devlive.features.desktop;
in
{
  config = lib.mkIf (desktop.type == "noctalia") {
    home.packages =
      with pkgs;
      [
        adw-gtk3
        adwaita-icon-theme
        bazaar
        # noctalia gtk4 color schema integration
        glib
        jellyfin-tui
        kdePackages.breeze-icons
        kdePackages.qt6ct
        libsForQt5.qt5ct
        networkmanagerapplet
        cliphist
        wl-clipboard
        wl-screenrec
        wl-mirror
      ]
      ++ desktop.extraHomePackages
      ++ desktop.noctalia.extraHomePackages
      ++ (
        if desktop.noctalia.package == pkgs.noctalia-shell-5 then
          [ desktop.noctalia.package ]
        else
          [ python3 ]
      )
      ++ (
        if desktop.noctalia.compositor == "niri" then
          [
            pkgs.xdg-desktop-portal-gnome
            pkgs.nautilus
          ]
        else
          [ ]
      );
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 32;
    };
    home.file.".config/qt6ct/qt6ct.conf".text = lib.generators.toINI { } {
      Appearance = {
        color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/noctalia.conf";
        custom_palette = true;
        icon_theme = "breeze-dark";
      };
      Fonts = {
        fixed = ''"FiraCode Nerd Font Mono Med,11,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
        general = ''"DejaVu Sans,11,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
      };
    };
    home.file.".config/qt5ct/qt5ct.conf".text = lib.generators.toINI { } {
      Appearance = {
        color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/noctalia.conf";
        custom_palette = true;
        icon_theme = "breeze-dark";
      };
      Fonts = {
        fixed = ''"FiraCode Nerd Font Mono Med,11,-1,5,50,0,0,0,0,0,Regular"'';
        general = ''"DejaVu Sans,11,-1,5,50,0,0,0,0,0,Regular"'';
      };
    };
    home.file.".config/systemd/user/xdg-desktop-portal-gnome.service" =
      lib.mkIf (desktop.noctalia.compositor == "niri")
        {
          source = "${pkgs.xdg-desktop-portal-gnome}/share/systemd/user/xdg-desktop-portal-gnome.service";
        };
    devlive.programs.eza.enable = true;
    devlive.programs.niri = lib.mkIf (desktop.noctalia.compositor == "niri") {
      enable = true;
    };
    devlive.programs.hyprland = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      enable = true;
    };
    devlive.programs.wezterm = {
      enable = true;
      defaultTerminalEmulator = true;
      settings.color_scheme = "Noctalia";
      settings.window_background_opacity = 0.8;
    };
    # File manager
    devlive.programs.yazi = {
      enable = true;
      plugins = {
        gvfs = pkgs.yaziPlugins.gvfs;
        mount = pkgs.yaziPlugins.mount;
        recycle-bin = pkgs.yaziPlugins.recycle-bin;
        wl-clipboard = pkgs.yaziPlugins.wl-clipboard;
      };
    };
    # Document viewer
    devlive.programs.zathura.enable = true;
    # System monitor
    programs.bottom.enable = true;
    # Image preview
    programs.imv.enable = true;
    # Media player
    programs.mpv.enable = true;
    programs.noctalia-shell = lib.mkIf (desktop.noctalia.package == pkgs.noctalia-shell) {
      enable = true;
      package = desktop.noctalia.package.override { calendarSupport = true; };
      settings = {
        appLauncher = {
          enableClipboardHistory = true;
          position = "follow_bar";
          terminalCommand = "devlive-desktop-terminal -e";
          viewMode = "grid";
        };
        bar = {
          density = "comfortable";
          monitors = [
            "eDP-1"
          ];
          position = "left";
          widgets = {
            center = [
              {
                id = "SystemMonitor";
              }
            ];
            left = [
              {
                icon = "rocket";
                id = "CustomButton";
                leftClickExec = "noctalia-shell ipc call launcher toggle";
              }
              {
                id = "Clock";
                usePrimaryColor = false;
              }
              {
                id = "Workspace";
                followFocusedScreen = true;
                hideUnoccupied = false;
              }
            ];
            right = [
              {
                id = "MediaMini";
              }
              {
                id = "Tray";
                pinned = [
                  "nm-applet"
                  "opensnitch-ui"
                  "udiskie"
                ]
                ++ (if config.devlive.services.tailscale.enable then [ "systray_*" ] else [ ])
                ++ (if desktop.enableTelegram then [ "Telegram Desktop" ] else [ ])
                ++ (if desktop.enableWhatsApp then [ "ZapZap" ] else [ ]);
              }
              {
                id = "NotificationHistory";
              }
              {
                id = "Battery";
              }
              {
                id = "Volume";
              }
              {
                id = "Brightness";
              }
              {
                id = "PowerProfile";
              }
              {
                id = "ControlCenter";
                colorizeDistroLogo = false;
                colorizeSystemIcon = "none";
                enableColorization = false;
                icon = "noctalia";
                useDistroLogo = true;
              }
            ];
          };
        };
        calendar = {
          cards = [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = true;
              id = "timer-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
          ];
        };
        colorSchemes = {
          useWallpaperColors = true;
          predefinedScheme = "Noctalia (default)";
        };
        dock = {
          enabled = false;
          backgroundOpacity = 0.8;
        };
        general = {
          allowPanelsOnScreenWithoutBar = true;
          compactLockScreen = true;
          enableShadows = false;
          lockScreenMonitors = [ "eDP-1" ];
          lockScreenBlur = 1;
          showScreenCorners = true;
          showSessionButtonsOnLockScreen = false;
        };
        idle = {
          enabled = true;
          screenOffTimeout = 600;
          lockTimeout = 660;
          suspendTimeout = 1800;
          fadeDuration = 5;
          screenOffCommand = "";
          lockCommand = "";
          suspendCommand = "";
          resumeScreenOffCommand = "";
          resumeLockCommand = "";
          resumeSuspendCommand = "echo nope";
          customCommands = "[]";
        };
        location = {
          name = "Kuta, Indonesia";
        };
        notifications = {
          location = "bottom_left";
          monitors = [
            "eDP-1"
          ];
        };
        templates = {
          gtk = true;
          qt = true;
          kcolorscheme = true;
          alacritty = config.programs.alacritty.enable;
          kitty = config.programs.kitty.enable;
          ghostty = config.programs.ghostty.enable;
          foot = config.programs.foot.enable;
          wezterm = config.programs.wezterm.enable;
          fuzzel = false;
          discord = false;
          pywalfox = false;
          vicinae = false;
          walker = false;
          code = config.devlive.programs.vscode.enable;
          spicetify = false;
          telegram = desktop.enableTelegram;
          cava = false;
          yazi = config.programs.yazi.enable;
          emacs = false;
          niri = if (desktop.noctalia.compositor == "niri") then true else false;
          hyprland = if (desktop.noctalia.compositor == "hyprland") then true else false;
          mango = false;
          zathura = config.programs.zathura.enable;
          zed = false;
          zenBrowser = false;
          helix = false;
          enableUserTemplates = false;
        };
        ui = {
          fontDefault = "DejaVu Sans";
          fontFixed = "FiraCode Nerd Font Mono";
          panelBackgroundOpacity = 0.8;
        };
      };
    };
    home.file.".config/noctalia/settings.toml" =
      lib.mkIf (desktop.noctalia.package == pkgs.noctalia-shell-5)
        {
          source = (pkgs.formats.toml { }).generate "noctalia-shell-5-settings.toml" {
            bar.default = {
              background_opacity = 0.8;
              border_width = 1.0;
              center = [
                "cpu"
                "temp"
                "ram"
                "network_rx"
                "network_tx"
              ];
              concave_edge_corners = false;
              end = [
                "widget"
                "media"
                "tray"
                "notifications"
                "clipboard"
                "network"
                "bluetooth"
                "volume"
                "brightness"
                "battery"
                "session"
                "control-center"
              ];
              margin_edge = 0;
              margin_ends = 16;
              position = "left";
              radius = 18;
              radius_bottom_left = 0;
              radius_top_left = 0;
              start = [
                "launcher"
                "clock"
                "date"
                "wallpaper"
                "workspaces"
              ];
              thickness = 48;
              widget_spacing = 8;
              monitor."HDMI-A-1".enabled = false;
            };

            battery = {
              warning_threshold = 20;
            };

            calendar = {
              enabled = true;
              account.personal_google = {
                type = "google";
              };
            };

            control_center = {
              sidebar = "full";
              sidebar_section = "full";
            };

            dock = {
              auto_hide = false;
              background_opacity = 0.8;
              border_width = 1.0;
              concave_edge_corners = false;
              enabled = true;
              margin_edge = 16;
              monitors = [ "eDP-1" ];
              position = "right";
              reserve_space = false;
              show_dots = true;
              smart_auto_hide = true;
            };

            idle = {
              behavior_order = [
                "lock"
                "screen-off"
                "suspend"
              ];
              behavior = {
                lock = {
                  action = "lock";
                  enabled = true;
                  timeout = 600;
                };
                screen-off = {
                  action = "screen_off";
                  enabled = true;
                  timeout = 660;
                };
                suspend = {
                  action = "suspend";
                  enabled = true;
                  lock_before_suspend = true;
                  timeout = 900;
                };
              };
            };

            lockscreen = {
              fingerprint = false;
              monitors = [ "eDP-1" ];
            };

            notification = {
              background_opacity = 0.8;
              monitors = [ "eDP-1" ];
              offset_y = 16;
              position = "bottom_left";
            };

            osd = {
              background_opacity = 0.8;
              lock_keys = false;
              monitors = [ "eDP-1" ];
              offset_y = 16;
              orientation = "horizontal";
              position = "top_center";
            };

            shell = {
              font_family = "Adwaita Mono";

              panel = {
                attach_clipboard = false;
                attach_control_center = false;
                attach_launcher = false;
                attach_session = false;
                attach_wallpaper = false;
                clipboard_placement = "auto";
                control_center_placement = "floating";
                floating_offset = 16;
                launcher_position = "auto";
                polkit_position = "auto";
                session_placement = "floating";
                transparency_mode = "soft";
                wallpaper_placement = "floating";
              };

              shadow = {
                alpha = 1.0;
                direction = "center";
              };
            };

            theme = {
              mode = "dark";
              source = "wallpaper";
              wallpaper_scheme = "m3-content";

              templates = {
                builtin_ids = [
                  "gtk3"
                  "gtk4"
                  "kcolorscheme"
                  "qt"
                ]
                ++ (if (config.programs.wezterm.enable) then [ "wezterm" ] else [ ])
                ++ (
                  if (desktop.noctalia.compositor == "hyprland") then
                    [ "hyprland" ]
                  else if (desktop.noctalia.compositor == "niri") then
                    [ "niri" ]
                  else
                    [ ]
                );
                community_ids =
                  (if (desktop.enableTelegram) then [ "telegram" ] else [ ])
                  ++ (if (config.devlive.programs.vscode.enable) then [ "vscode" ] else [ ])
                  ++ (if (config.devlive.programs.yazi.enable) then [ "yazi" ] else [ ])
                  ++ (if (config.devlive.programs.zathura.enable) then [ "zathura" ] else [ ])
                  ++ (if (config.devlive.programs.zed-editor.enable) then [ "zed" ] else [ ]);
              };
            };

            wallpaper = {
              directory = "~/Pictures/Wallpapers";

              default = {
                path = "${config.home.homeDirectory}/Pictures/Wallpapers/wallhaven_j38o75.jpg";
              };
            };

            weather = {
              auto_locate = true;
            };

            widget = {
              control-center = {
                custom_image = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
                custom_image_colorize = true;
                glyph = "snowflake";
                scale = 1.5;
              };
              cpu = {
                show_label = false;
                show_value = false;
              };
              network = {
                show_label = false;
                show_value = false;
              };
              network_rx = {
                show_label = false;
                show_value = false;
              };
              network_tx = {
                show_label = false;
                show_value = false;
              };
              ram = {
                show_label = false;
                show_value = false;
              };
              temp = {
                show_label = false;
                show_value = false;
              };
              workspaces = {
                capsule_padding = 8.0;
              };
            };
          };
        };
    # Enable zen browser transparency and custom layout
    programs.zen-browser.profiles.default.settings =
      lib.mkIf config.devlive.programs.zen-browser.enable
        {
          "browser.tabs.inTitlebar" = 0;
          "zen.view.compact.hide-tabbar" = true;
          "zen.view.compact.hide-toolbar" = false;
          "zen.view.grey-out-inactive-windows" = false;
          "zen.widget.linux.transparency" = true;
        };

    services.flameshot = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          useGrimAdapter = true;
        };
      };
    };
    services.tailscale-systray.enable = lib.mkIf (config.devlive.services.tailscale.enable) true;
    services.udiskie = {
      enable = true;
      settings = {
        program_options = {
          file_manager = "devlive-desktop-terminal -e yazi";
        };
      };
      tray = "always";
    };
    services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;
    services.polkit-gnome = lib.mkIf (desktop.noctalia.compositor == "niri") {
      enable = true;
    };

    dconf.settings."org/gnome/desktop/interface".gtk-theme = "adw-gtk3";
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    systemd.user.services.networkmanagerapplet = {
      Unit = {
        Description = "NetworkManager applet";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "application/postscript" = "org.pwmt.zathura.desktop";
      "image/vnd.djvu" = "org.pwmt.zathura.desktop";

      "image/bmp" = "imv.desktop";
      "image/gif" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/jpg" = "imv.desktop";
      "image/pjpeg" = "imv.desktop";
      "image/png" = "imv.desktop";
      "image/tiff" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/x-bmp" = "imv.desktop";
      "image/x-pcx" = "imv.desktop";
      "image/x-png" = "imv.desktop";
      "image/x-portable-anymap" = "imv.desktop";
      "image/x-portable-bitmap" = "imv.desktop";
      "image/x-portable-graymap" = "imv.desktop";
      "image/x-portable-pixmap" = "imv.desktop";
      "image/x-tga" = "imv.desktop";
      "image/x-xbitmap" = "imv.desktop";
      "image/heic" = "imv.desktop";
    };
  };
}
