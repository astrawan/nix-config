{ config, lib, pkgs, ... }:

let
  user = config.devlive.user;
in
{
  config = lib.mkIf (user.gpg.publicKey.fingerprint != null) {
    programs.gpg = {
      enable = true;
      publicKeys = lib.mkIf(user.gpg.publicKey.fingerprint != null) ([
        {
          source = builtins.fetchurl {
            url = "https://keys.openpgp.org/vks/v1/by-fingerprint/${user.gpg.publicKey.fingerprint}";
            sha256 = "sha256:1327xyqlk6ylxmhj85xfgg8vxqzkwjdr7av8lhcwdc04kxxnpd3p";
          };
          trust = "ultimate";
        }
      ]);
    };
    services.gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = if (config.devlive.host.defaultShell == pkgs.fish) then true else false;
      enableScDaemon = true;
      enableSshSupport = true;
      sshKeys = user.gpg.sshKeys;
    };
  };
}
