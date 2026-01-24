{ config, lib, ... }:

let
  infra = config.devlive.infra;
in
{
  options.devlive.infra.atlcrowd = lib.mkOption {
    type = lib.types.submodule(
      import ./atlopts.nix { inherit lib; }
    );
    default = {
      enable = false;
      host = "crowd.${infra.domain}";
      port = 443;
      user = "atlcrowd";
      group = "atlcrowd";
      home = "/var/atlassian/application-data/crowd";
    };
  };
}
