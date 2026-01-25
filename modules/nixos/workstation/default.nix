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
  };
}
