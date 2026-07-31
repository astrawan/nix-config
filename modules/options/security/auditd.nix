{
  lib,
  ...
}:

{
  options.devlive.security.auditd = {
    enable = lib.mkEnableOption "auditd";
  };
}
