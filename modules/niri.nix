{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    niri
    alacritty
    wofi
    xwayland-satellite
    dunst
    polkit_gnome
    variety
  ];

}
