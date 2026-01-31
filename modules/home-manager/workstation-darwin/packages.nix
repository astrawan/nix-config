{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    stats
    telegram-desktop
  ];
}
