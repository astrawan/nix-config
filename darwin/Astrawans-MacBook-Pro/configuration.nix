{ pkgs, ... }:

{

  environment.systemPackages = [ pkgs.neovim
  ];
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 6;
}
