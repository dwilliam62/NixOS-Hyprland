{
  description = "KooL's NixOS-Hyprland";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    #wallust.url = "git+https://codeberg.org/explosion-mental/wallust?ref=dev";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # hyprland development
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    wezterm,
    ...
  }: let
    system = "x86_64-linux";
    host = "p520-jakos";
    username = "dwilliams";
    defaultPackage.x86_64-linux = wezterm.packages.x86_64-linux.default;

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
          inputs.distro-grub-themes.nixosModules.${system}.default
        ];
      };
    };
  };
}
