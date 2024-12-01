{
     description = "ddubs's NixOS-Hyprland";

inputs = {
  nixpkgs.url = "nixpkgs/release-24.11";
  #nixpkgs.url = "nixpkgs/nixos-unstable";
  hyprland.url = "github:hyprwm/Hyprland";
  distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
  wezterm.url = "github:wez/wezterm?dir=nix";

  neovim-src = {
      url = "github:neovim/neovim";
      flake = false;
   };


#  hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
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
      #allowUnsupportedSystem = true;
      # binary cache substituters 
      extra-substituters = [
        "https://cache.nixos.org"
        "https://hydra.nixos.org"
      ];
      # extra-trusted-public-keys = [...];
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

