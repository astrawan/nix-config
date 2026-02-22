{ ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      omniwm = (super.callPackage ../pkgs/omniwm.nix {});
    })
  ];
}
