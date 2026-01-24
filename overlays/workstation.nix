{ ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      sddm-noctalia = (super.callPackage ../pkgs/sddm-noctalia.nix {});
      yaziPlugins = super.yaziPlugins // {
        gvfs = (super.callPackage ../pkgs/yazi/plugins/gvfs.nix {});
      };
    })
  ];
}
