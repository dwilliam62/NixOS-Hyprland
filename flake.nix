{
     description = "KooL's NixOS-Hyprland";

inputs = {
  nixpkgs.url = "nixpkgs/release-24.11";
  # ... other inputs

  hyprland.url = "github:hyprwm/Hyprland";
  # ... other inputs

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
      # Add the binary cache substituters here
      extra-substituters = [
        "https://cache.nixos.org"
        "https://hydra.nixos.org"
      ];
      # Add the public keys if required (check documentation)
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

