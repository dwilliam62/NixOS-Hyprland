{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [

    # System Packages
    baobab
    clang
    cpufrequtils
    duf
    eza
    ffmpeg
    glib # for gsettings to work
    gsettings-qt
    killall
    libappindicator
    libnotify
    openssl # required by Rainbow borders
    pciutils
    vim
    wget
    xdg-user-dirs
    xdg-utils

    fastfetch
    (mpv.override { scripts = [ mpvScripts.mpris ]; }) # with tray
    ranger

    # Hyprland Stuff
    #  override for AGS to keep it at v1
       (ags.overrideAttrs (oldAttrs: {
        inherit (oldAttrs) pname;
        version = "1.8.2";
      }))

    #  override for aquamarine 
       (aquamarine.overrideAttrs (oldAttrs: {
        inherit (oldAttrs) pname;
        version = "0.4.5";
      }))

   #   override for hyprland 
       (hyprland.overrideAttrs (oldAttrs: {
        inherit (oldAttrs) pname;
        version = "0.45.2";
      }))

   #   override for cava 
   #    (cava.overrideAttrs (oldAttrs: {
   #     inherit (oldAttrs) pname;
   #     version = "0.10.3";
   #   }))

    #version 2.0 not backward compatible with v1
    #ags 
    btop
    #cava
    cmake
    cliphist
    eog
    #gnome-system-monitor
    file-roller
    grim
    gtk-engine-murrine # for gtk themes
    hyprcursor # requires unstable channel
    hypridle # requires unstable channel
    imagemagick
    inxi
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum # kvantum
    networkmanagerapplet
    nwg-look # requires unstable channel
    nvtopPackages.full
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pyprland
    #qt5ct
    # Replaced by libsForQt5.qt5ct
    libsForQt5.qt5ct
    qt6ct
    qt6.qtwayland
    qt6Packages.qtstyleplugin-kvantum # kvantum
    rofi-wayland
    slurp
    swappy
    swaynotificationcenter
    swww
    unzip
    wallust
    wl-clipboard
    wlogout
    yad
    yt-dlp

  ];

  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
    terminus_font
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
