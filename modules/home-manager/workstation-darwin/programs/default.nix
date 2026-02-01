{
  imports = [
    ../../common/programs
    ./fish.nix
    ./wezterm.nix
    ./yazi.nix
  ];

  config = {
    programs.aerospace = {
      enable = true;
      launchd = {
        enable = true;
      };
      userSettings = {
        gaps = {
          inner.horizontal = 10;
          inner.vertical = 10;
          outer.bottom = 10;
          outer.left = 10;
          outer.right = 10;
          outer.top = 6;
        };
        mode.main.binding = {
          alt-slash = "layout tiles horizontal vertical";
          alt-comma = "layout accordion horizontal vertical";

          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";

          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";

          alt-1 = "workspace 1";
          alt-2 = "workspace 2";
          alt-3 = "workspace 3";
          alt-4 = "workspace 4";
          alt-5 = "workspace 5";
          alt-6 = "workspace 6";
          alt-7 = "workspace 7";
          alt-8 = "workspace 8";
          alt-9 = "workspace 9";

          alt-shift-1 = "move-node-to-workspace 1";
          alt-shift-2 = "move-node-to-workspace 2";
          alt-shift-3 = "move-node-to-workspace 3";
          alt-shift-4 = "move-node-to-workspace 4";
          alt-shift-5 = "move-node-to-workspace 5";
          alt-shift-6 = "move-node-to-workspace 6";
          alt-shift-7 = "move-node-to-workspace 7";
          alt-shift-8 = "move-node-to-workspace 8";
          alt-shift-9 = "move-node-to-workspace 9";
        };
        start-at-login = true;
      };
    };
    services.jankyborders = {
      enable = true;
      settings = {
        active_color = "0xfff1c232";
        width = 6.0;
      };
    };

    programs.mpv.enable = true;

    devlive.programs.eza.enable = true;
    devlive.programs.yazi.enable = true;
    devlive.programs.zathura.enable = true;
  };
}
