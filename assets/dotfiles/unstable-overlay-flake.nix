{
  description = "Just a Little NixOS Hyperland Flake";
      
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
      nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; #Unstable
      hyprland.url = "github:hyprwm/Hyprland"; #Hyprland Development
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
      wallust.url = "git+https://codeberg.org/explosion-mental/wallust";
  };

  outputs = 
    inputs@{ self,nixpkgs,nixpkgs-unstable,hyprland,hyprland-qtutils, ... }:
    let
      system = "x86_64-linux";
      host = "atlantis";
      username = "tikisri";

      pkgs = import nixpkgs {
        inherit system;
           config = {
           allowUnfree = true;
      };
    };

      genericModules = [
        ({ config, pkgs, ... }:
          {
            nixpkgs.overlays =
              [
                overlay-unstable
              ];
          }
        )
      ];

    overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
    };

    in
      {
    nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem rec {
        specialArgs = { 
            inherit system;
            inherit inputs;
            inherit username;
            inherit host;
            };
               modules = genericModules ++ [
                  ./hosts/${host}/config.nix
                  inputs.distro-grub-themes.nixosModules.${system}.default
                ];
            };
        };
    };
}
