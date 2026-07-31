{ config, pkgs, ... }:

{
  devlive.host = {
    timeZone = "Asia/Makassar";
    defaultLocale = "en_US.UTF-8";
    defaultShell = pkgs.fish;
  };

  devlive.user = {
    id = 1000;
    name = "astra";
    fullName = "Astrawan Wayan";
    gpg = {
      publicKey.fingerprint = "E69DFA903C39AA28F990464EA6113EB4F50442EA";
      # Get the imported key keygrip value with command `gpg -k --with-keygrip`
      sshKeys = [ "50A310CD04463CA3653738D4C245D087C6AD5612" ];
    };
    groups = [
      "networkmanager"
      "wheel"
    ];
    email = "astra@pm.me";
    packages = with pkgs; [
      home-manager
    ];
  };

  devlive.features.core-utils.enable = true;
  devlive.features.devel-utils.enable = true;

  devlive.programs.bash.enable = true;
  devlive.programs.fish.enable = true;
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
