{
  description = "DevLive Nix Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/release-25.11";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixos-wsl, home-manager, nix-darwin, noctalia, zen-browser, ... }:
    let
      lib = nixpkgs.lib;
      darwinSystem = "aarch64-darwin";
      linuxSystem = "x86_64-linux";
    in {
      nixosConfigurations = {
        pandorabox = lib.nixosSystem {
          system = linuxSystem;
          modules = [
            ({ ... }: {
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
          pkgs = (nixpkgs.legacyPackages.${linuxSystem}.extend noctalia.overlays.default);
          modules = [
            ({ ... }: {
              imports = [
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
            ({ ... }: {
              imports = [
                zen-browser.homeModules.beta
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
    };
}
