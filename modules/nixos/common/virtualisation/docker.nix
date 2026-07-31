{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.devlive.virtualisation.docker;
in
{
  config = lib.mkIf cfg.enable {
    virtualisation = {
      docker.enable = true;
    };
    environment.systemPackages = [ pkgs.docker-buildx ];

    users.users."${config.devlive.user.name}".extraGroups = [ "docker" ];
  };
}
