{ lib }:
{
  options = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    host = lib.mkOption {
      type = lib.types.str;
    };
    port = lib.mkOption {
      type = lib.types.port;
    };
    user = lib.mkOption {
      type = lib.types.str;
    };
    group = lib.mkOption {
      type = lib.types.str;
    };
    home = lib.mkOption {
      type = lib.types.path;
    };
  };
}
