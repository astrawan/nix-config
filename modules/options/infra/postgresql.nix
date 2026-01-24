{ lib, ... }:

{
  options.devlive.infra.postgresql = {
    enable = lib.mkEnableOption "postgresql"; 
    host = lib.mkOption {
      type = lib.types.str;
    };
    port = lib.mkOption {
      type = lib.types.port;
      default = 5432;
    };
  };
}
