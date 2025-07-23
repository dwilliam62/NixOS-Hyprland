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

let
hyprQtSupport = pkgs.symlinkJoin {
name = "hyprland-qt-style";
paths = [ inputs.hyprland-qt-style.packages.${pkgs.system}.default ];
};

  environment.systemPackages = (with pkgs; [
    #waybar  # if wanted experimental next line
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
    atop
  ]) ++ [
	  python-packages
  ];

environment.sessionVariables.QML_IMPORT_PATH = "${hyprQtSupport}/lib/qt-6/qml";
  }
