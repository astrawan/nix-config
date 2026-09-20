{
  description = "DevLive Nix Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    helium-browser.url = "github:oxcl/nix-flake-helium-browser";
    helium-browser.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    dbx.url = "github:t8y2/dbx/v0.6.16";
    dbx.inputs.nixpkgs.follows = "nixpkgs";
    noctalia.url = "github:noctalia-dev/noctalia-shell/legacy-v4";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";
    noctalia5.url = "github:noctalia-dev/noctalia-shell/v5.1.0";
    noctalia5.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      nix-cachyos-kernel,
      nixos-wsl,
      helium-browser,
      home-manager,
      nix-darwin,
      sops-nix,
      dbx,
      noctalia,
      noctalia5,
      zen-browser,
      ...
    }:
    let
      lib = nixpkgs.lib;
      darwinSystem = "aarch64-darwin";
      linuxSystem = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        pandorabox = lib.nixosSystem {
          system = linuxSystem;
          modules = [
            ({ ... }: {
              nixpkgs.overlays = [
                nix-cachyos-kernel.overlays.pinned
              ];
              imports = [
                ./overlays/workstation.nix
                ./modules/options
                ./modules/nixos/workstation
                ./profiles/astra/workstation-linux.nix
                ./nixos/pandorabox/configuration.nix
              ];
            })
          ];
        };
        pandorabox-v2 = lib.nixosSystem {
          system = linuxSystem;
          modules = [
            ({ ... }: {
              nixpkgs.overlays = [
                nix-cachyos-kernel.overlays.pinned
              ];
              imports = [
                ./overlays/workstation.nix
                ./modules/options
                ./modules/nixos/workstation
                ./profiles/astra/workstation-linux.nix
                ./nixos/pandorabox-v2/configuration.nix
              ];
            })
          ];
        };
        pandorabox-wsl = lib.nixosSystem {
          system = linuxSystem;
          modules = [
            nixos-wsl.nixosModules.default
            ({ ... }: {
              imports = [
                ./modules/options
                ./modules/nixos/wsl
                ./profiles/astra/wsl.nix
                ./nixos/pandorabox-wsl/configuration.nix
              ];
            })
          ];
        };
        pgsql17 = lib.nixosSystem {
          system = linuxSystem;
          modules = [
            ({ modulesPath, ... }: {
              imports = [
                (modulesPath + "/virtualisation/proxmox-lxc.nix")
                ./modules/options
                ./modules/nixos/lxc
                ./profiles/infra/options.nix
                ./nixos/pgsql17/configuration.nix
              ];
            })
          ];
        };
        hydra = lib.nixosSystem {
          system = linuxSystem;
          modules = [
            ({ modulesPath, ... }: {
              imports = [
                (modulesPath + "/virtualisation/proxmox-lxc.nix")
                ./modules/options
                ./modules/nixos/lxc
                ./profiles/infra/options.nix
                ./nixos/hydra/configuration.nix
              ];
            })
          ];
        };
      };
      darwinConfigurations = {
        Astrawans-MacBook-Pro = nix-darwin.lib.darwinSystem {
          modules = [
            home-manager.darwinModules.home-manager
            ({ modulesPath, ... }: {
              imports = [
                ./modules/options
                ./modules/darwin/workstation
                ./profiles/astra/workstation-darwin.nix
                ./darwin/Astrawans-MacBook-Pro/configuration.nix
              ];

              nixpkgs.hostPlatform = darwinSystem;
              system.primaryUser = "astra";

              devlive.host.system = "darwin";
            })
          ];
        };
      };
      homeConfigurations = {
        astra-linux = home-manager.lib.homeManagerConfiguration {
          pkgs = (
            (nixpkgs.legacyPackages.${linuxSystem}.extend noctalia.overlays.default).extend (
              final: prev: {
                noctalia-shell-5 = noctalia5.packages.${linuxSystem}.default;
                dbx-desktop = dbx.packages.${linuxSystem}.dbx-desktop;
              }
            )
          );
          modules = [
            sops-nix.homeManagerModules.sops
            ({ ... }: {
              imports = [
                helium-browser.homeModules.default
                noctalia.homeModules.default
                zen-browser.homeModules.beta
                ./overlays/workstation.nix
                ./modules/options
                ./modules/home-manager/workstation-linux
                ./profiles/astra/workstation-linux.nix
                ./home-manager/astra/home.nix
              ];
            })
          ];
        };
        astra-wsl = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = linuxSystem; };
          modules = [
            sops-nix.homeManagerModules.sops
            ({ ... }: {
              imports = [
                ./modules/options
                ./modules/home-manager/wsl
                ./profiles/astra/wsl.nix
                ./home-manager/astra/home.nix
              ];
            })
          ];
        };
        astra-darwin = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = darwinSystem; };
          modules = [
            sops-nix.homeManagerModules.sops
            ({ ... }: {
              imports = [
                zen-browser.homeModules.beta
                ./overlays/darwin.nix
                ./modules/options
                ./modules/home-manager/workstation-darwin
                ./profiles/astra/workstation-darwin.nix
                ./home-manager/astra/home.nix
              ];

              devlive.host.system = "darwin";
            })
          ];
        };
      };
      hydraJobs = {
        packages.${linuxSystem} = {
          # https://github.com/xddxdd/nix-cachyos-kernel/blob/d722a934d795f6c4d9930a0b252483bcdd3e541d/flake.nix#L111
          inherit (nix-cachyos-kernel.packages.${linuxSystem})
            linux-cachyos-bore-lto-x86_64-v3
            linux-cachyos-bore-lto-x86_64-v4
            linux-cachyos-bore-x86_64-v3
            linux-cachyos-bore-x86_64-v4
            linux-cachyos-eevdf
            linux-cachyos-eevdf-lto
            ;
          inherit (dbx.packages.${linuxSystem})
            dbx-desktop
            ;
          noctalia-shell-5 = noctalia5.packages.${linuxSystem}.default;
        };
      };
    };
}
