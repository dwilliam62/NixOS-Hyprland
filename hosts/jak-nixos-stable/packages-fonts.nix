# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options

{ pkgs, inputs, ...}: let

  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
        ]
    );

  in {

  environment.systemPackages = (with pkgs; [
    #waybar  # if wanted experimental next line
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [
	  python-packages
  ];

  }
