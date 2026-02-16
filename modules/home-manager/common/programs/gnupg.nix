{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.gnupg;
in
{
  config = lib.mkIf cfg.enable {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = if (config.devlive.host.defaultShell == pkgs.fish) then true else false;
      enableScDaemon = true;
      enableSshSupport = true;
      sshKeys = cfg.sshKeys;
    };
  };
}
