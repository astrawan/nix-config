{ config, lib, ... }:

let
  cfg = config.devlive.lxc;
in
{
  config = lib.mkIf cfg.enable {
    nix.settings.sandbox = false;

    proxmoxLXC = {
      manageNetwork = false;
      privileged = true;
    };

    services.fstrim.enable = false; # Let Proxmox host handle fstrim
    security.pam.services.sshd.allowNullPassword = true;
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
          PermitRootLogin = "yes";
          PasswordAuthentication = true;
          PermitEmptyPasswords = "yes";
      };
    };
    # Cache DNS lookups to improve performance
    services.resolved = {
      extraConfig = ''
        Cache=true
        CacheFromLocalhost=true
      '';
    };

    devlive.host.type = "lxc";
  };
}
