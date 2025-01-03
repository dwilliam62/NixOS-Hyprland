{
     description = "ddubs's NixOS-Hyprland";

inputs = {
  nixpkgs.url = "nixpkgs/release-24.11";
  hyprland.url = "github:hyprwm/Hyprland";
  hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
  # Ghosty Terminal
   ghostty.url = "github:ghostty-org/ghostty";
   #3 NVIDA graphics switcher
   envycontrol.url = github:bayasdev/envycontrol;
};

outputs = inputs @ {
  self,
  nixpkgs,
  ...
}: let
  system = "x86_64-linux";
  host = "p520-jakos";
  username = "dwilliams";
  #defaultPackage.x86_64-linux = wezterm.packages.x86_64-linux.default;

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
        #inputs.distro-grub-themes.nixosModules.${system}.default
      ];
    };
  };
};
}

