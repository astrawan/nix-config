{ config, lib, pkgs, ... }:

{
  config = {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    # boot.loader.grub = {
    #   enable = true;
    #   efiSupport = true;
    #   # efiInstallAsRemovable = true;
    #   device = "nodev";
    # };
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # playmouth
    boot.consoleLogLevel = 3;
    boot.initrd.systemd.enable = true;
    boot.initrd.verbose = false;
    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 0;
    };
    boot.kernelParams = [
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ] ++ (
      if (config.devlive.boot.plymouth.enable) then
        [
          "quiet"
          "splash"
        ]
      else
        [ ]
    );
    boot.blacklistedKernelModules = [ "mmc_block" ];
    boot.plymouth = lib.mkIf(config.devlive.boot.plymouth.enable) {
      enable = true;
      theme = "bgrt";
    };

    # boot.loader.timeout = 0;
  };
}
