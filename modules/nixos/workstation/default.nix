{ config, ... }:

{
  imports = [
    ../common/users.nix
    ./features
    ./programs
    ./security
    ./services
    ./virtualisation
    ./boot.nix
    ./networking.nix
  ];

  config = {
    devlive.host.type = "workstation";
    users.users."${config.devlive.user.name}".shell = config.devlive.host.defaultShell;
  };
}
