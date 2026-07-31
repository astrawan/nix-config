{ ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      sddm-noctalia = (super.callPackage ../pkgs/sddm-noctalia.nix { });
      notema = (super.callPackage ../pkgs/notema.nix { });
    })
  ];
}
