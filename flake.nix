{
  description = "Rucadi’s unified NixOS + Home-Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rucadi-nixpkgs.url = "github:rucadi/nixpkgs/whatsapp";
    tkmm-flake.url = "github:rucadi/nixpkgs/tkmm";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    eden-flake.url = "github:erurus/eden";
    hyprland.url = "github:hyprwm/Hyprland";

       niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    niri,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    rucadiPkgs = import inputs.rucadi-nixpkgs {inherit system;};
    tkmm = import inputs.tkmm-flake {inherit system;};
    eden = inputs.eden-flake.defaultPackage.${system};
    hypr = inputs.hyprland.packages.${system}.default;
    quickshellPkg = inputs.quickshell.packages.${system}.default;
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          niri.nixosModules.niri

          inputs.home-manager.nixosModules.home-manager
          ({
            config,
            pkgs,
            lib,
            ...
          }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.rucadi = ./home.nix;
          })
        ];
        specialArgs = {
          inherit rucadiPkgs tkmm eden hypr quickshellPkg;
        };
      };
    };

    homeConfigurations = {
      rucadi = inputs.home-manager.lib.homeManagerConfiguration {
        inherit system;
        pkgs = pkgs;
        modules = [./home.nix];
        specialArgs = {
          inherit rucadiPkgs tkmm eden hypr quickshellPkg;
        };
      };
    };

    packages = flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        rucadiPkgs = import inputs.rucadi-nixpkgs {inherit system;};
      in {
        default = rucadiPkgs.whatsapp-electron or null;
      }
    );

    devShells = flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        rucadiPkgs = import inputs.rucadi-nixpkgs {inherit system;};
        quickshellPkg = inputs.quickshell.packages.${system}.default;
      in {
        default = pkgs.mkShell {
          buildInputs = [
            rucadiPkgs.whatsapp-electron
            quickshellPkg
          ];
        };
      }
    );

    formatter."${system}" = let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
      pkgs.alejandra;
  };
}
