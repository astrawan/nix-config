{ config, pkgs, ... }:

{
  devlive.host = {
    timeZone = "Asia/Makassar";
    defaultLocale = "en_US.UTF-8";
    defaultShell = pkgs.fish;
  };

  devlive.user = {
    name = "astra";
    fullName = "Astrawan Wayan";
    groups = [ "networkmanager" "wheel" ];
    email = "astra@pm.me";
    packages = with pkgs; [
      home-manager
    ];
  };

  devlive.features.core-utils.enable = true;
  devlive.features.devel-utils.enable = true;

  devlive.programs.bash.enable = true;
  devlive.programs.fish.enable = true;
  devlive.programs.gnupg.enable = true;
  devlive.programs.jellyfin-tui = {
    enable = true;
    settings = {
      servers = [
        {
          name = "Home Server";
          url = "https://jellyfin.stack.devlive.cloud";
          username = "${config.devlive.user.name}";
          password_file = "${config.xdg.configHome}/sops-nix/secrets/password_jellyfin";
        }
      ];
    };
  };
}
