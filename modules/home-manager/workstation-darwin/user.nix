{
  config,
  lib,
  pkgs,
  ...
}:

let
  user = config.devlive.user;
in
{
  imports = [
    ../common/user.nix
  ];

  config = lib.mkIf (user.gpg.publicKey.fingerprint != null) {
    services.gpg-agent.pinentry.program = pkgs.pinentry_mac;
  };
}
