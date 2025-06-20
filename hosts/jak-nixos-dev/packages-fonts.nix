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
  # System Packages

    #waybar  # if wanted experimental next line
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [
	  python-packages
  ];

  # FONTS
  fonts = {
    packages = with pkgs; [
            # Fonts moved to modules/packages.nix
    ];
  };
  

  programs = {
	  firefox.enable = false;
      virt-manager.enable = false;
      thunar = { 
        enable = true;
          plugins = with pkgs.xfce; [
             exo
             thunar-archive-plugin
             thunar-volman
             tumbler
              ];
      };
    
    steam = {
      enable = false;
      gamescopeSession.enable = false;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
    };
    

	
  };


}
