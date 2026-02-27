{ config, lib, ... }:

let
  cfg = config.devlive.virtualisation.docker;
in
{
  config = lib.mkIf cfg.enable {
    virtualisation = {
      docker.enable = true;
    };

    users.users."${config.devlive.user.name}".extraGroups = [ "docker" ];
  };
}
