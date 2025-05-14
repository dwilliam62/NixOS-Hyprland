{
  pkgs,
  inputs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
 
 # Hyprland Stuff
    appimage-run
    atop
    bat
    bottom
    cmatrix
    dua
    figlet
    google-chrome
    bc
    brightnessctl
    (btop.override { 
            cudaSupport = true; 
            rocmSupport = true;
        })
    cava
    cargo
    clang
    cmake
    cliphist
    cpufrequtils
    curl
    duf
    dysk
    dunst
    eog
    eza
    fastfetch
    findutils
    ffmpeg
    fd
    feh
    file-roller
    jq
    gnumake
    grim
        #gtk-engine-murrine # for gtk themes
        #gnome-system-monitor
    inxi
    imagemagick
    gcc
    git
    glib # for gsettings to work
    killall
        #kdePackages.qt6ct
        #kdePackages.qtwayland
        # kdePackages.qtstyleplugin-kvantum #kvantum
    lazydocker
    libappindicator
    libnotify
    loupe
        #libsForQt5.qtstyleplugin-kvantum # kvantum
        #libsForQt5.qt5ct
    (mpv.override { scripts = [ mpvScripts.mpris ]; }) # with tray
    openssl # required by Rainbow borders
    pciutils
    nethogs
    networkmanagerapplet
    nitrogen
        #nvtopPackages.full
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pyprland
    rofi-wayland
        #qt6ct
        #qt6.qtwayland
        #qt6Packages.qtstyleplugin-kvantum # kvantum
        #gsettings-qt
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
    wget
    xdg-user-dirs
    xdg-utils
    wlogout
    xarchiver
    yad
    yad
    yazi
    yt-dlp


 ## My packages 


    (inputs.ghostty.packages.${pkgs.system}.default)
    (inputs.ags.packages.${pkgs.system}.default)
    (inputs.wfetch.packages.${pkgs.system}.default)
    (inputs.focal.packages.${pkgs.system}.default)

    # Utils
    glances
        #gnomeExtensions.kando-integration
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
        #pika-backup
    pipes
    pipes-rs
    ripgrep
    socat
    starship
    tldr
    ugrep
    unrar
    #v4l-utils
    obs-studio
    zoxide

    # Hardware related
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
        #varia

    # Virtuaizaiton
    virt-viewer
    libvirt

    # Video
     vlc
     jellyfin-media-player
        # handbrake

    # Terminals
    kitty
    putty 
    ptyxis
    remmina
    tmux
    wezterm


    # Hyprland related
    hyprpolkitagent
    hyprlang
        #hyprshot
        #hyprcursor
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
      victor-mono
    ];
  };

  # Added per VIMjoyner vidoe on setting up nixd
  nix.nixPath = ["nixpkgs = ${inputs.nixpkgs}"];
}
