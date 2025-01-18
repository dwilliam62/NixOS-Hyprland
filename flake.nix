{
  description = "ddubs' Hyprland Flake";
      
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; #Unstable
    hyprland.url = "github:hyprwm/Hyprland"; #Hyprland Development
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    wallust.url = "git+https://codeberg.org/explosion-mental/wallust";
    ghostty.url = "github:ghostty-org/ghostty";
    envycontrol.url = "github:bayasdev/envycontrol";
    wfetch.url = "github:iynaix/wfetch";
    focal.url = "github:iynaix/focal";
    #distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = 
  inputs@{ self, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      host = "explorer";
      username = "dwilliams";

      unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      pkgs = import nixpkgs {
        inherit system;
           config = {
           allowUnfree = true;
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
      inherit unstable;
    };
    modules = [
      ./hosts/${host}/config.nix
        #inputs.distro-grub-themes.nixosModules.${system}.default
        ];
      };
    };
  };
}

