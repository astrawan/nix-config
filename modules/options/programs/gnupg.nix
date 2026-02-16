{ config, lib, pkgs, ... }:

let
  cfg = config.devlive.programs.gnupg;
in 
{
  options.devlive.programs.gnupg = {
    enable = lib.mkEnableOption "gnupg";
    sshKeys = lib.mkOption {
      type = lib.types.nullOr (lib.types.listOf lib.types.str);
      default = null;
      description = "Which GPG keys (by keygrip) to expose as SSH keys";
    };
  };
}
