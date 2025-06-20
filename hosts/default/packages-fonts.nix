# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options

{ 
pkgs, 
inputs,
...
}: let

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
  ]) ++ [
	  python-packages
  ];

  # FONTS
  fonts.packages = with pkgs; [
    # system fonts moved to modules/packag.nix
 	];
  
  programs = {
	  hyprland = {
      enable = true;
     	  #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
		    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; #xdph-git
     	  
        portalPackage = pkgs.xdg-desktop-portal-hyprland; # xdph none git
  	  xwayland.enable = true;
    };

	
	  firefox.enable = false;
	  git.enable = true;
    nm-applet.indicator = true;
    #neovim.enable = true;

	  thunar.enable = true;
	  thunar.plugins = with pkgs.xfce; [
		  exo
		  mousepad
		  thunar-archive-plugin
		  thunar-volman
		  tumbler
  	  ];
	
    virt-manager.enable = false;
    
    #steam = {
    #  enable = true;
    #  gamescopeSession.enable = true;
    #  remotePlay.openFirewall = true;
    #  dedicatedServer.openFirewall = true;
    #};
    
    xwayland.enable = true;

  };


  }
