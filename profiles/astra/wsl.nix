{ ... }:

{
  imports = [
    ./common.nix
  ];
  devlive.wsl.enable = true;
  devlive.virtualisation.podman.enable = true;
}
