{ config, lib, ... }:

let
  cfg = config.devlive.programs.fish;
in
{
  config = lib.mkIf (cfg.enable) {
    # Enable homebrew integration
    devlive.programs.fish.interactiveShellInit = ''
      [ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv fish)"
    '';
  };
}
