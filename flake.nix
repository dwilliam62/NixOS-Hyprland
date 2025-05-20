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
    lix-module,
    ...
  }: let
    system = "x86_64-linux";
    host = "NixOS-HyprXero";
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
          ./hosts/${host}/config.nix
          lix-module.nixosModules.default
          chaotic.nixosModules.nyx-cache
          chaotic.nixosModules.nyx-overlay
          chaotic.nixosModules.nyx-registry
          #inputs.distro-grub-themes.nixosModules.${system}.default
        ];
      };
    };
  };
}
