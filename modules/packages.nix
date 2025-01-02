{
  pkgs,
  inputs,
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
    aquamarine
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
    handbrake
    hyprcursor # requires unstable channel
    hypridle # requires unstable channel
    hyprutils
    hyprlock
    hyprpolkitagent
    hyprpaper
    hyprshot
    hyprcursor
    hyprland
    hyprlang
    imagemagick
    inxi
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum # kvantum
    libsForQt5.qt5ct
    nethogs
    networkmanagerapplet
    nitrogen
    nwg-look # requires unstable channel
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
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
    wlogout
    yad
    yt-dlp


 ## My packages 


    (inputs.ghostty.packages.${pkgs.system}.default)
    (inputs.envycontrol.packages.${pkgs.system}.default)
    (inputs.hyprland-qtutils.packages.${pkgs.system}.default)


    alacritty
    arandr
    appimage-run
    atop
    atuin
    bat
    bottom
    brightnessctl
    clang
    clang-tools
    cmatrix
    cpufetch
    cpuid
    cpu-x
    dig
    discord-canary
    distrobox
    dua
    #fh
    figlet
    flameshot
    freeoffice
    foot
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
    gcc
    git
    github-desktop
    glances
    gotop
    gping
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    gsmartcontrol
    #gtop
    htop
    hyfetch
    imagemagick
    iotop
    ipfetch
    jellyfin-media-player
    lazygit
    libvirt
    light
    lm_sensors
    lsd
    lolcat
    luarocks
    luajitPackages.lua-lsp
    lua-language-server
    lunarvim
    #mc
    meld
    meson
    mission-center
    ncdu
    ncftp
    nixpkgs-fmt
    nixd
    nixfmt-rfc-style
    nix-tree
    nodejs_22
    neofetch
    neovide
    nh
    nix-ld
    nomacs
    nwg-drawer
    nwg-dock-hyprland
    nwg-launchers
    nwg-panel
    nwg-bar
    nwg-displays
    nwg-wrapper
    nwg-look
    nwg-menu
        #obs-studio
    okular
    ouch
    pika-backup
    pfetch
    picom
    ptyxis
    polybar
    powertop
    putty
    remmina
    #rio #terminal emulator
    ripgrep
    smartmontools
    socat
    stacer
    sxhkd
    tilix
    tldr
    tmux
    ugrep
    unrar
    v4l-utils
    vesktop
    virt-viewer
    vlc
    vscode-fhs
    w3m
    #warp-terminal
    waypaper
    #wayvnc
    wezterm
    wf-recorder
    wtfis
    variety
    volumeicon
    xclip
    yad
    #yazi
    zed-editor
    #zellij
    zig
    zoxide
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
