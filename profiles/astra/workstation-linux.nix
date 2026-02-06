{ config, lib, pkgs, ... }:

let
  desktop = config.devlive.features.desktop;
in
{
  imports = [
    ./common.nix
    ./workstation-common.nix
  ];

  devlive.features.desktop = {
    type = "noctalia";
    extraHomePackages = with pkgs; [
        freerdp
        gimp
        gradia
        inkscape
        libreoffice
        popcorntime
        telegram-desktop
        wireshark
    ];
    gnome.extraHomePackages = lib.mkIf (desktop.type == "gnome") (with pkgs; [
        dconf-editor
        foliate
        fragments
        gnome-extension-manager
        gnome-tweaks
        lock
    ]);
    noctalia = lib.mkIf (desktop.type == "noctalia") {
      compositor = "niri";
      wallpaperRolling.enable = true;
    };
  };
  devlive.features.devel-android.enable = true;
  devlive.features.uutils.enable = true;

  devlive.programs.aegisub.enable = true;
  devlive.programs.deja-dup = {
    enable = true;
    include-list = ["/home/${config.devlive.user.name}/Documents/Synchronizable"];
    google = {
      enable = true;
    };
    periodic = true;
  };
  devlive.programs.keystore-explorer.enable = true;
  devlive.programs.qbittorrent.enable = lib.mkIf (desktop.noctalia.compositor == "hyprland") true;
  devlive.programs.fragments.enable = lib.mkIf (desktop.noctalia.compositor == "niri") true;
  devlive.programs.vaults = {
    enable = true;
    settings = {
      encrypted_data_directory = "/home/${config.devlive.user.name}/Documents/Synchronizable/Vaults";
    };
  };

  devlive.security.auditd.enable = true;
  devlive.security.sudo-rs.enable = true;

  devlive.services.flatpak.enable = true;
  devlive.services.opensnitch.enable = true;
  devlive.services.openssh.enable = false;
  devlive.services.pipewire.enable = true;
  devlive.services.usbguard.enable = true;

  devlive.virtualisation.libvirtd.enable = true;
  devlive.virtualisation.podman.enable = true;
  devlive.virtualisation.waydroid.enable = true;
}
