{ pkgs, ... }:
{
  imports = [
    ../common/features
  ];

  home.packages = with pkgs; [
    # ssh authentication via security key is not support on macos
    openssh
  ];
}
