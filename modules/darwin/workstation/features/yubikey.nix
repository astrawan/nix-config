{ config, lib, ... }:

let
  cfg = config.devlive.features.yubikey;
in
{
  homebrew.casks = lib.mkIf(cfg.enable) [
    "yubico-authenticator"
  ];
}
