{ config, lib, ... }:

let
  cfg = config.devlive.user;
in 
{
  options.devlive.user = {
    id = lib.mkOption {
      type = with lib.types; nullOr int;
      default = null;
    };
    name = lib.mkOption {
      type = lib.types.str;
    };
    fullName = lib.mkOption {
      type = lib.types.str;
    };
    gpg = {
      publicKey = {
        fingerprint = lib.mkOption {
          type = with lib.types; nullOr str;
          default = null;
        };
        id = lib.mkOption {
          type = with lib.types; nullOr str;
          readOnly = true;
          default = if (cfg.gpg.publicKey.fingerprint != null) then
            (builtins.substring 24 (builtins.stringLength cfg.gpg.publicKey.fingerprint - 24) cfg.gpg.publicKey.fingerprint)
          else null;
        };
      };
      sshKeys = lib.mkOption {
        type = lib.types.nullOr (lib.types.listOf lib.types.str);
        default = null;
        description = "Which user GPG keys (by keygrip) to expose as SSH keys. Get the imported key keygrip value with command `gpg -k --with-keygrip`";
      };
    };
    groups = lib.mkOption {
      type = with lib.types; listOf str;
    };
    email = lib.mkOption {
      type = lib.types.str;
    };
    packages = lib.mkOption {
      type = with lib.types; listOf package;
    };
  };
}
