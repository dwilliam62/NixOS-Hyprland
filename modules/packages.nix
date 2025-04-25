{
  pkgs,
  inputs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
 
 # Hyprland Stuff
    #  override for AGS to keep it at v1
       (ags.overrideAttrs (oldAttrs: {
        inherit (oldAttrs) pname;
        version = "1.8.2";
      }))

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
    yazi
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
        #(inputs.envycontrol.packages.${pkgs.system}.default)
        #(inputs.hyprland-qtutils.packages.${pkgs.system}.default)
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
    figlet
    glances
    gnomeExtensions.kando-integration
    gotop
    gping
    htop
    hyfetch
    iotop
    ipfetch
    kando
    lolcat
    lsd
    microfetch
    neofetch
    oh-my-posh
    pfetch
    ncdu
    ncftp
    pika-backup
    pipes
    pipes-rs
    ripgrep
    socat
    starship
    tldr
    ugrep
    unrar
    #v4l-utils
    #obs-studio
    zoxide

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
    bash-language-server
    clang
    clang-tools
    dig
    docker-compose-language-service
    evil-helix
    git
    gitnuro
    lazygit
    luarocks
    luajitPackages.lua-lsp
    lua-language-server
    marksman
    nix-tree
    nodejs_22
    nh
    nil
    nix-ld
    taplo
    vscode-fhs
    vscode-langservers-extracted
    w3m
    yaml-language-server
    zig

    # Internet
    wtfis
    discord-canary
    distrobox
    #freeoffice
    varia

    # Virtuaizaiton
    virt-viewer
    libvirt

    # Video
     vlc
     jellyfin-media-player
        # handbrake

    # Terminals
    #warp-terminal
        #alacritty
    #foot
    kitty
    putty 
    ptyxis
    remmina
    tmux
    wezterm

    # bspwm
    flameshot
    nomacs
    tilix
    picom
    polybar
    sxhkd
    polkit_gnome
    xclip
    yad
    variety
    volumeicon

    # Hyprland related
    aquamarine
    bc  # for rofi menus
    glaze
    hypridle 
    hyprutils
    hyprlock
    hyprpolkitagent
    hyprpaper
    hyprland
    hyprlang
    hyprshot
    hyprcursor
    imagemagick
    mesa
    nwg-drawer
    nwg-dock-hyprland
    nwg-launchers
    nwg-panel
    nwg-bar
    nwg-displays
    nwg-wrapper
    nwg-look
    nwg-menu
    waypaper
    wf-recorder
    xdg-desktop-portal-hyprland

    # Editor
    lunarvim
    multimarkdown
    neovide

    # River
     mako
     wofi
     dmenu

    # Wayfire related
    dmenu
    wf-config
    wofi
    mako

  ];

 fonts = {
    packages = with pkgs; [
      dejavu_fonts
      fira-code
      fira-code-symbols
      font-awesome
      hackgen-nf-font
      ibm-plex
      inter
      jetbrains-mono
      material-icons
      maple-mono.NF
      minecraftia
      nerd-fonts.im-writing
      nerd-fonts.blex-mono
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-monochrome-emoji
      powerline-fonts
      roboto
      roboto-mono
      symbola
      terminus_font
    ];
  };

  # Added per VIMjoyner vidoe on setting up nixd
  nix.nixPath = ["nixpkgs = ${inputs.nixpkgs}"];
}
