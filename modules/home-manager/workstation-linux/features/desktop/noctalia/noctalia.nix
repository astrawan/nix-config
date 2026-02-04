{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
  wallpaperDayFilename = builtins.baseNameOf desktop.noctalia.wallpaperRolling.day.image;
  wallpaperNightFilename = builtins.baseNameOf desktop.noctalia.wallpaperRolling.night.image;
in
{
  config = lib.mkIf (desktop.type == "noctalia") {
    home.packages = with pkgs; [
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
      # noctalia schema installation
      python3
      wayclip
    ] ++desktop.extraHomePackages ++desktop.noctalia.extraHomePackages;
    home.file.".config/qt6ct/qt6ct.conf".text = lib.generators.toINI {} {
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
    home.file.".config/qt5ct/qt5ct.conf".text = lib.generators.toINI {} {
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
    devlive.programs.eza.enable = true;
    devlive.programs.wezterm = {
      enable = true;
      defaultTerminalEmulator = true;
      settings.color_scheme = "Noctalia";
    };
    # File manager
    devlive.programs.yazi = {
      enable = true;
      plugins = {
        gvfs = pkgs.yaziPlugins.gvfs;
        mount = pkgs.yaziPlugins.mount;
        recycle-bin = pkgs.yaziPlugins.recycle-bin;
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
    programs.quickshell.enable = true;
    programs.noctalia-shell = {
      enable = true;
      package = pkgs.noctalia-shell.override { calendarSupport = true; };
      settings = {
        appLauncher = {
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
                ];
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
        colorSchemes.predefinedScheme = "Noctalia (default)";
        general = {
          allowPanelsOnScreenWithoutBar = true;
          compactLockScreen = true;
          enableShadows = false;
          showScreenCorners = true;
          showSessionButtonsOnLockScreen = false;
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
          code = false;
          spicetify = false;
          telegram = true;
          cava = false;
          yazi = config.programs.yazi.enable;
          emacs = false;
          niri = if (desktop.noctalia.compositor == "niri") then true else false;
          hyprland = if (desktop.noctalia.compositor == "hyprland") then true else false;
          mango = false;
          zed = false;
          zenBrowser = config.devlive.programs.zen-browser.enable;
          helix = false;
          enableUserTemplates = false;
        };
        ui = {
          fontDefault = "DejaVu Sans";
          fontFixed = "FiraCode Nerd Font Mono";
          panelBackgroundOpacity = 1;
        };
      };
      systemd.enable = true;
    };
    # Enable zen browser transparency and custom layout
    programs.zen-browser.profiles.default.settings = lib.mkIf config.devlive.programs.zen-browser.enable {
      "browser.tabs.inTitlebar" = if (desktop.noctalia.compositor == "hyprland") then 0 else 2;
      "zen.view.compact.hide-tabbar" = true;
      "zen.view.compact.hide-toolbar" = false;
      "zen.view.grey-out-inactive-windows" = false;
      "zen.widget.linux.transparency" = if (desktop.noctalia.compositor == "hyprland") then true else false;
    };
    wayland.windowManager.hyprland = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      enable = true;
      settings = {
        source = [
          "${config.xdg.configHome}/hypr/autostart.conf"
          "${config.xdg.configHome}/hypr/binds.conf"
          "${config.xdg.configHome}/hypr/common.conf"
          "${config.xdg.configHome}/hypr/env.conf"
          "${config.xdg.configHome}/hypr/input.conf"
          "${config.xdg.configHome}/hypr/laf.conf"
          "${config.xdg.configHome}/hypr/permissions.conf"
          "${config.xdg.configHome}/hypr/rules.conf"
          "${config.xdg.configHome}/hypr/noctalia/noctalia-colors.conf"
        ]
        ++(if config.programs.ghostty.enable then [ "${config.xdg.configHome}/hypr/rules-ghostty.conf" ] else [])
        ++(if config.programs.wezterm.enable then [ "${config.xdg.configHome}/hypr/rules-wezterm.conf" ] else []);
      };
    };

    xdg.configFile."hypr/autostart.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/autostart.conf;
    };
    xdg.configFile."hypr/binds.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/binds.conf;
    };
    xdg.configFile."hypr/common.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/common.conf;
    };
    xdg.configFile."hypr/env.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/env.conf;
    };
    xdg.configFile."hypr/input.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/input.conf;
    };
    xdg.configFile."hypr/laf.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/laf.conf;
    };
    xdg.configFile."hypr/permissions.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/permissions.conf;
    };
    xdg.configFile."hypr/rules.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      source = ./config/hypr/rules.conf;
    };
    xdg.configFile."hypr/rules-ghostty.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland" && config.programs.ghostty.enable) {
      source = ./config/hypr/rules-ghostty.conf;
    };
    xdg.configFile."hypr/rules-wezterm.conf" = lib.mkIf (desktop.noctalia.compositor == "hyprland" && config.programs.wezterm.enable) {
      source = ./config/hypr/rules-wezterm.conf;
    };

    xdg.configFile."niri/animations.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/animations.kdl;
    };
    xdg.configFile."niri/config.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/config.kdl;
    };
    xdg.configFile."niri/binds.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/binds.kdl;
    };
    xdg.configFile."niri/input.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/input.kdl;
    };
    xdg.configFile."niri/output.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/output.kdl;
    };
    xdg.configFile."niri/layer-rule.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/layer-rule.kdl;
    };
    xdg.configFile."niri/layout.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/layout.kdl;
    };
    xdg.configFile."niri/window-rule.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/window-rule.kdl;
    };
    xdg.configFile."niri/workspace.kdl" = lib.mkIf (desktop.noctalia.compositor == "niri") {
      source = ./config/niri/workspace.kdl;
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
    services.hypridle = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      enable = true;
      settings = {
        general = {
          ignore_dbus_inhibit = false;
          lock_cmd = "noctalia-shell ipc call lockScreen lock";
        };
        listener = [
          # Lock the screen
          {
            # 5 minutes
            timeout = 300;
            on-timeout = "noctalia-shell ipc call lockScreen lock";
          }
          # Turn off the screen
          {
            # 15 minutes
            timeout = 900;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
    services.swayidle = lib.mkIf (desktop.noctalia.compositor == "niri") {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = "${(lib.getExe config.programs.noctalia-shell.package)} ipc call lockScreen lock";
        }
        {
          timeout = 900;
          command = "${(lib.getExe pkgs.niri)} msg action power-off-monitors";
          resumeCommand = "${(lib.getExe pkgs.niri)} msg power-on-monitors";
        }
      ];
    };
    services.tailscale-systray.enable = true;
    services.udiskie = {
      enable = true;
      settings = {
        program_options = {
          file_manager = "devlive-desktop-terminal -e yazi";
        };
      };
      tray = "always";
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

    home.file."${config.home.homeDirectory}/Pictures/Wallpapers/${wallpaperDayFilename}" = lib.mkIf(desktop.noctalia.wallpaperRolling.enable) {
      source = desktop.noctalia.wallpaperRolling.day.image;
    };
    home.file."${config.home.homeDirectory}/Pictures/Wallpapers/${wallpaperNightFilename}" = lib.mkIf(desktop.noctalia.wallpaperRolling.enable) {
      source = desktop.noctalia.wallpaperRolling.night.image;
    };

    systemd.user.services."devlive-wallpaper@" = lib.mkIf (desktop.noctalia.wallpaperRolling.enable) {
      Service = {
        ExecStart = "${config.home.profileDirectory}/bin/noctalia-shell ipc call wallpaper set ${config.home.homeDirectory}/Pictures/Wallpapers/%i ''";
        Restart = "on-failure";
        RestartSec = 10;
      };
      Unit = {
        Requires = [ "noctalia-shell.service" ];
      };
    };

    systemd.user.timers = lib.mkIf(desktop.noctalia.wallpaperRolling.enable) {
      "devlive-wallpaper-night" = {
        Install = {
          WantedBy = [
            "timers.target"
          ];
        };
        Timer = {
          OnCalendar = "*-*-* ${desktop.noctalia.wallpaperRolling.night.time}";
          Persistent = true;
          Unit = "devlive-wallpaper@${wallpaperNightFilename}.service";
        };
      };
      "devlive-wallpaper-day" = {
        Install = {
          WantedBy = [
            "timers.target"
          ];
        };
        Timer = {
          OnCalendar = "*-*-* ${desktop.noctalia.wallpaperRolling.day.time}";
          Persistent = true;
          Unit = "devlive-wallpaper@${wallpaperDayFilename}.service";
        };
      };
    };
  };
}
