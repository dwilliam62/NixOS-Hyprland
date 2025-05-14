{
  description = "ddubs Hyprland Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland"; #Hyprland Development
    wallust.url = "git+https://codeberg.org/explosion-mental/wallust";
    ghostty.url = "github:ghostty-org/ghostty";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    wfetch.url = "github:iynaix/wfetch";
    focal.url = "github:iynaix/focal";
    ags.url = "github:aylur/ags/v1";  #AGS v1
    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    chaotic,
    ags,
    ...
  }: let
    system = "x86_64-linux";
    host = "NixOS-Hyprland";
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
          chaotic.nixosModules.nyx-cache
          chaotic.nixosModules.nyx-overlay
          chaotic.nixosModules.nyx-registry
          #inputs.distro-grub-themes.nixosModules.${system}.default
        ];
      };
    };
  };
}
