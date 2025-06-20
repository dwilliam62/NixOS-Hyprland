{
  description = "ddubs Hyprland Flake";
    inputs = {
  nixpkgs = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
    ref = "nixos-25.05";
  };

  hyprland = {
    type = "github";
    owner = "hyprwm";
    repo = "Hyprland";
  };

  wallust = {
    type = "git";
    url = "https://codeberg.org/explosion-mental/wallust";
  };

  ghostty = {
    type = "github";
    owner = "ghostty-org";
    repo = "ghostty";
  };

  chaotic = {
    type = "github";
    owner = "chaotic-cx";
    repo = "nyx";
    ref = "nyxpkgs-unstable";
  };

  wfetch = {
    type = "github";
    owner = "iynaix";
    repo = "wfetch";
  };

  focal = {
    type = "github";
    owner = "iynaix";
    repo = "focal";
  };

  ags = {
    type = "github";
    owner = "aylur";
    repo = "ags";
    ref = "v1";
  };

   hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
        #hyperpanel = {
        #type = "github";
        #owner = "Jas-SinghFSU";
        #repo = "HyprPanel";
        # };

    lix-module = {
    type = "tarball";
    url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};


  outputs = inputs @ {
    self,
    nixpkgs,
    chaotic,
    ags,
    hyprpanel,
    lix-module,
    ...
  }: let
    system = "x86_64-linux";
    host = "jak-nixos-dev";
    username = "dwilliams";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit username;
          inherit host;
        };
        modules = [
         {
          nixpkgs.overlays = [
              inputs.hyprpanel.overlay
             ];
          }
          ./hosts/${host}/config.nix
          ./modules/services.nix
          ./modules/portals.nix
          ./modules/niri.nix
          ./modules/theme.nix
          ./modules/packages.nix
          ./modules/doas.nix
          ./modules/starship.nix
          lix-module.nixosModules.default
          chaotic.nixosModules.nyx-cache
          chaotic.nixosModules.nyx-overlay
          chaotic.nixosModules.nyx-registry
        ];
      };
    };
  };
}
