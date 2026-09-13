{ config, lib, ... }:

let
  cfg = config.devlive.lxc;
in
{
  imports = [
    ../common/users.nix
  ];
  config = lib.mkIf cfg.enable {
    nix.settings.sandbox = false;

    networking.nameservers = [
      "172.21.21.1"
    ];
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

    devlive.host.type = "lxc";
  };
}
