{ ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      atlcrowd = (super.callPackage ../pkgs/atlcrowd.nix {});
      atljira = (super.callPackage ../pkgs/atljira.nix {});
      atlservicedesk = (super.callPackage ../pkgs/atlservicedesk.nix {});
      atlbitbucket = (super.callPackage ../pkgs/atlbitbucket.nix {});
      atlbamboo = (super.callPackage ../pkgs/atlbamboo.nix {});
      atlconfluence = (super.callPackage ../pkgs/atlconfluence.nix {});
    })
  ];
}

