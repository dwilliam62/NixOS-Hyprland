{
  description = "ddubs Hyprland Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    hyprland.url = "github:hyprwm/Hyprland"; #Hyprland Development
    wallust.url = "git+https://codeberg.org/explosion-mental/wallust";
    ghostty.url = "github:ghostty-org/ghostty";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    wfetch.url = "github:iynaix/wfetch";
    focal.url = "github:iynaix/focal";
    ags.url = "github:aylur/ags/v1";  #AGS v1

    lix-module = {
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
    host = "xps15";
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
