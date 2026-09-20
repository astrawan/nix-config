{ config, ... }:

{
  homebrew = {
    enable = true;
    casks = [
      "gpg-suite"
      "tor-browser"
      "xquartz"
    ]
    ++ (if (config.devlive.programs.discord.enable) then [ "discord" ] else [ ])
    ++ (if (config.devlive.features.desktop.enableTelegram) then [ "telegram-desktop" ] else [ ]);
  };
}
