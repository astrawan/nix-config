{ config, lib, ... }:

{
  imports = [
    ../common/programs
  ];

  config = {
    programs.mpv.enable = true;

    devlive.programs.eza.enable = true;
    # Enable homebrew integration
    devlive.programs.fish.interactiveShellInit = ''
      [ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv fish)"
    '';
    devlive.programs.wezterm = lib.mkIf (config.devlive.programs.wezterm.enable) {
      settings = {
        macos_window_background_blur = 60;
        window_background_opacity = 0.7;
      };
    };
    devlive.programs.yazi.enable = true;
    devlive.programs.zathura.enable = true;
  };
}
