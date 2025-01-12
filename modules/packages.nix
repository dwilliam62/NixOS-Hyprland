{
  pkgs,
  inputs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
 
    # plugins

    #  pkgs.hyprlandPlugins.hyprtrails
    #  pkgs.hyprlandPlugins.hyprexpo


 ## From systemPackages.nix
 # System Packages

 #  Overrides

 # Hyprland Stuff
    #  override for AGS to keep it at v1
       (ags.overrideAttrs (oldAttrs: {
        inherit (oldAttrs) pname;
        version = "1.8.2";
      }))

    #  override for Yazi to keep it at v3.3
      (yazi.overrideAttrs (oldAttrs: {
        inherit (oldAttrs) pname;
        version = "0.3.3";
      }))

    #  override for aquamarine 
        #   (aquamarine.overrideAttrs (oldAttrs: {
        #  inherit (oldAttrs) pname;
        # version = "0.4.5";
        # }))

   #   override for hyprland 
        #       (hyprland.overrideAttrs (oldAttrs: {
        #inherit (oldAttrs) pname;
        # version = "0.45.0";
        #  }))


    cava
    clang
    cpufrequtils
    duf
    eza
    fastfetch
    ffmpeg
    glib # for gsettings to work
    gsettings-qt
    killall
    libappindicator
    libnotify
    (mpv.override { scripts = [ mpvScripts.mpris ]; }) # with tray
    openssl # required by Rainbow borders
    pciutils
    wget
    xdg-user-dirs
    xdg-utils
   


 #version 2.0 not backward compatible with v1
    #ags 
    arandr
    #btop-rocm
    (btop.override { 
            cudaSupport = true; 
            rocmSupport = true;
        })
    cmake
    cargo
    cliphist
    dunst
    eog
    fd
    feh
    file-roller
    grim
    gnumake
    gtk-engine-murrine # for gtk themes
    inxi
    jq
    libsForQt5.qtstyleplugin-kvantum # kvantum
    libsForQt5.qt5ct
    nethogs
    networkmanagerapplet
    nitrogen
    nwg-look 
    pamixer
    pavucontrol
    playerctl
    pyprland
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
    wdisplays
    wl-clipboard
    wlr-randr
    wlogout
    yad
    yt-dlp


 ## My packages 


    (inputs.ghostty.packages.${pkgs.system}.default)
    (inputs.envycontrol.packages.${pkgs.system}.default)
    (inputs.hyprland-qtutils.packages.${pkgs.system}.default)
    (inputs.wfetch.packages.${pkgs.system}.default)
    (inputs.focal.packages.${pkgs.system}.default)

    # Utils
    arandr
    appimage-run
    atop
    #atuin
    bat
    bottom
    cmatrix
    dua
    glances
    gotop
    gping
    htop
    hyfetch
    iotop
    ipfetch
    lsd
    microfetch
    neofetch
    pfetch
    ncdu
    ncftp
    figlet
    okular
    ouch
    pika-backup
    ripgrep
    socat
    tldr
    ugrep
    unrar
    #v4l-utils
    #obs-studio
    zoxide
    starship
    lolcat


    # Hardware related
    brightnessctl
    cpufetch
    cpuid
    cpu-x
    gsmartcontrol
    smartmontools
    light
    lm_sensors
    pfetch
    mission-center
    stacer
    pfetch
    powertop

    # Development related
    clang
    clang-tools
    dig
    gcc
    git
    github-desktop
    lazygit
    luarocks
    luajitPackages.lua-lsp
    lua-language-server
    meld
    meson
    nixpkgs-fmt
    nixd
    nixfmt-rfc-style
    nix-tree
    nodejs_22
    nh
    nix-ld
    vscode-fhs
    w3m
    zig

    # Internet
    discord-canary
    vesktop
    wtfis
    discord-canary
    distrobox
    freeoffice

    # Virtuaizaiton
    virt-viewer
    libvirt

    # Video
     vlc
    jellyfin-media-player
    handbrake

    # Terminals
    #warp-terminal
    alacritty
    foot
    kitty
    putty 
    ptyxis
    tmux
    wezterm
    remmina

    # bspwm
    sxhkd
    tilix
    flameshot
    picom
    polybar
    variety
    volumeicon
    xclip
    yad
    nomacs
    polkit_gnome

    # Hyprland related
    mesa
    glaze
    aquamarine
    imagemagick
    waypaper
    wf-recorder
    nwg-drawer
    nwg-dock-hyprland
    nwg-launchers
    nwg-panel
    nwg-bar
    nwg-displays
    nwg-wrapper
    nwg-look
    nwg-menu
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    hyprcursor 
    hypridle 
    hyprutils
    hyprlock
    hyprpolkitagent
    hyprpaper
    hyprshot
    hyprcursor
    hyprland
    hyprlang
    xdg-desktop-portal-hyprland

    # Editor
    neovide
    zed-editor
    lunarvim

    # River
     mako
     wofi
     dmenu

    # fish shell and plugins
     #fish
     #fishPlugins.done
     #fishPlugins.fzf
     #fishPlugins.forgit
     #fishPlugins.hydro
     #fishPlugins.bass
     #fzf
     #fishPlugins.grc
     #grc
    #  End fish packages
    

    # Wayfire related
    dmenu
    wf-config
    wofi
    mako

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

  # Added per VIMjoyner vidoe on setting up nixd
  nix.nixPath = ["nixpkgs = ${inputs.nixpkgs}"];
}
