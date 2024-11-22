{
  description = "KooL's NixOS-Hyprland";

  inputs = {
    nixpkgs.url = "nixpkgs/release-24.11";
    #nixpkgs.url = "nixpkgs/nixos-unstable";
    #wallust.url = "git+https://codeberg.org/explosion-mental/wallust?ref=dev";
    hyprland.url = "github:hyprwm/Hyprland";

   # Optional features currently disable
   # I am not using plugins anymore 
   #  Return IRL 
   #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # hyprland development
   # hyprland-plugins = {
   #   url = "github:hyprwm/hyprland-plugins";
   #   inputs.hyprland.follows = "hyprland";
   # };

    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    wezterm.url = "github:wez/wezterm?dir=nix";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
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
      overlays = [
        inputs.hyprpanel.overlay
      ];
      config = {
        allowUnfree = true;
        allowUnsupportedSystem = true;
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
