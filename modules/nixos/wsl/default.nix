{ config, lib, ... }:

let
  cfg = config.devlive.wsl;
in 
{
  imports = [
    ../common/users.nix
    ./virtualisation
  ];
  config = lib.mkIf cfg.enable {
    wsl.enable = true;
    wsl.defaultUser = config.devlive.user.name;

    devlive.host.type = "wsl";
  };
}
