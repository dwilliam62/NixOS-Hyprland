{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
 
    # Override for cliphis  aiting for update to reach unstable bracnh
    #  10-16-24
    #  https://nixpk.gs/pr-tracker.html?pr=348887

    #    (cliphist.overrideAttrs (_old: {
    #     src = pkgs.fetchFromGitHub {
    #       owner = "sentriz";
    #       repo = "cliphist";
    #       rev = "c49dcd26168f704324d90d23b9381f39c30572bd";
    #       sha256 = "sha256-2mn55DeF8Yxq5jwQAjAcvZAwAg+pZ4BkEitP6S2N0HY=";
    #       };
    #        vendorHash = "sha256-M5n7/QWQ5POWE4hSCMa0+GOVhEDCOILYqkSYIGoy/l0=";
    #      }))

    # plugins

    #  pkgs.hyprlandPlugins.hyprtrails
    #  pkgs.hyprlandPlugins.hyprexpo

#    (pkgs.neovide.overrideAttrs {
#    nativeBuildInputs = with pkgs; [
#        makeWrapper
#        pkg-config
#        python3 # skia
#        removeReferencesTo
#       ];
#    })

 ## From systemPackages.nix
 # System Packages

 #  Overrides

 # Hyprland Stuff
    #  override for AGS to keep it at v1
       (ags.overrideAttrs (oldAttrs: {
        inherit (oldAttrs) pname;
        version = "1.8.2";
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
   
    # SDDM
#       kdePackages 
  #    sddm 
  #    libsForQt5.qt5.qtgraphicaleffects
  #    where-is-my-sddm-theme


 #version 2.0 not backward compatible with v1
    #ags 
    btop
    cmake
    cliphist
    eog
    file-roller
    grim
    gtk-engine-murrine # for gtk themes
    hyprcursor # requires unstable channel
    hypridle # requires unstable channel
    hyprpolkitagent
    imagemagick
    inxi
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum # kvantum
    libsForQt5.qt5ct
    networkmanagerapplet
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
    wl-clipboard
    wlogout
    yad
    yt-dlp


 ## My packages 


    (inputs.wezterm.packages.${pkgs.system}.default)
 #   (inputs.hyprpanel.packages.${pkgs.system}.default)


    alacritty
    appimage-run
    aquamarine
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
    fh
    figlet
    flameshot
    freeoffice
    foot
    # fish shell and plugins
    fish
    fishPlugins.done
    fishPlugins.fzf
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.bass
    fzf
    fishPlugins.grc
    grc
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
    gtop
    htop
    hyfetch
    hyprlang
    hyprshot
    hyprutils
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
    mc
    meld
    meson
    #mission-center
    ncdu
    ncftp
    nixpkgs-fmt
    nixd
    nixfmt-rfc-style
    nodejs_22
    neofetch
    #neovide
    neovim
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
    obs-studio
    okular
    ouch
    pfetch
    ptyxis
    powertop
    putty
    quickemu
    #  QuickGUI won't build
    #quickgui
    remmina
    rio #terminal emulator
    ripgrep
    smartmontools
    socat
    stacer
    tilix
    tldr
    tmux
    ugrep
    unrar
    v4l-utils
    vesktop
    virt-manager
    virt-viewer
    vlc
    vscode-fhs
    w3m
    warp-terminal
    waypaper
    wayvnc
    wf-recorder
    wtfis
    xclip
    yad
    yazi
    zed-editor
    zellij
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
