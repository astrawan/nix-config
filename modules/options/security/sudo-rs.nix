{ lib, ... }:

{
  options.devlive.security.sudo-rs = {
    enable = lib.mkEnableOption "sudo-rs";
  };
}
