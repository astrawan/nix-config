{ pkgs, ... }:

{
  devlive.host = {
    timeZone = "Asia/Makassar";
    defaultLocale = "en_US.UTF-8";
  };

  devlive.user = {
    name = "astra";
    fullName = "Astrawan Wayan";
    groups = [ "wheel" ];
    email = "astra@pm.me";
    packages = with pkgs; [
      home-manager
    ];
  };

  devlive.lxc.enable = true;
  devlive.infra.jdkPackage = pkgs.jdk21_headless;
}
