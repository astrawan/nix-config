{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
in
{
  config = lib.mkIf (desktop.type == "noctalia") {
    environment.systemPackages = with pkgs; [
      tuigreet
    ] ++desktop.extraPackages ++desktop.noctalia.extraPackages;
    environment.variables = {
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORMTHEME="qt6ct";
    };
    programs.evolution.enable = true;
    programs.hyprland = lib.mkIf (desktop.noctalia.compositor == "hyprland") {
      enable = true;
      xwayland.enable = true;
    };
    programs.niri = lib.mkIf (desktop.noctalia.compositor == "niri") {
      enable = true;
    };
    hardware.bluetooth.enable = true;
    services.displayManager.autoLogin = {
      enable = true;
      user = "${config.devlive.user.name}";
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
          user = "${config.devlive.user.name}";
        };
        initial_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
          user = "${config.devlive.user.name}";
        };
      };
      useTextGreeter = true;
    };

    security.polkit = lib.mkIf (desktop.noctalia.compositor == "niri") {
      enable = true;
    };
    services.gnome.gnome-keyring = lib.mkIf (desktop.noctalia.compositor == "niri") {
      enable = true;
    };
    services.gvfs.enable = true;
    services.power-profiles-daemon.enable = true;

    # enable usb auto-mount
    services.udisks2.enable = true;

    services.upower.enable = true;
  };
}
