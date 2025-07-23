{
  description = "ddubs Hyprland Flake";
    inputs = {
  nixpkgs = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
    ref = "nixos-unstable";
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

  wfetch = {
    type = "github";
    owner = "iynaix";
    repo = "wfetch";
  };

  ags = {
    type = "github";
    owner = "aylur";
    repo = "ags";
    ref = "v1";
  };

   hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

   quickshell = {
        url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    # Support for QT6 apps  
    hyprland-qt-style.url = "github:hyprwm/hyprland-qt-support";


};


  outputs = inputs @ {
    self,
    nixpkgs,
    ags,
    hyprpanel,
    ...
  }: let
    system = "x86_64-linux";
    host = "jakos-vm";
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
          ./modules/local-hardware-clock.nix
          ./modules/portals.nix
          ./modules/packages.nix
          ./modules/services.nix
          ./modules/security.nix
          ./modules/starship.nix
          ./modules/theme.nix
          ./modules/amd-drivers.nix
          ./modules/nvidia-drivers.nix
          ./modules/nvidia-prime-drivers.nix
          ./modules/intel-drivers.nix
          ./modules/vm-guest-services.nix
          ./modules/quickshell.nix
        ];
      };
    };
  };
}
