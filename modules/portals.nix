{
lib,
config,
pkgs,
...}: 

{
    

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr  
      #pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

# Prioritize the wlroots portal for your desktop
xdg.portal.config = {
  Niri = {
    default = [ "wlr" "gtk" ];  # Prioritize wlr, fallback to gtk
    "org.freedesktop.impl.portal.FileChooser" = [ "wlr" ];  # Specifically for file dialogs
  };
  common = {
    default = [ "wlr" "gtk" ];
  };
};

}
