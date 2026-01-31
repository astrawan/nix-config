{ config, pkgs, ... }:

{
  imports = [
    ./features
    ./homebrew.nix
    ./programs
    ./users.nix
  ];

  config = {
    devlive.host.type = "workstation";

    environment.shells = [
      config.devlive.host.defaultShell
    ];
    users.users."${config.devlive.user.name}".shell = config.devlive.host.defaultShell;

    fonts.packages = with pkgs; [ nerd-fonts.fira-code ];
  };
}
