{
  pkgs,
  inputs,
  unstable,
  ...
}: {

  programs = {
        neovim.enable = true;
        niri = {
          enable = true;
          package = pkgs.niri;
        };
    };

  environment.systemPackages = with pkgs; [
  
    # Your fastfetch script
    (pkgs.writeShellScriptBin "ff" ''
      fastfetch -c ~/.config/fastfetch/fastfetch-system-times.config.jsonc
    '')

    # Your Wfetch Randomizer script
    (pkgs.writeShellScriptBin "wf" ''
      # Wfetch Randomizer
      # Choose between multiple command options randomly
      # Author: Don Williams
      # Revision History
      #==============================================================
      v0.1      5-15-2025        Initial release

      # Generate a random number (0 to 4)
      choice=$((RANDOM % 5))

      # Execute one of the five commands based on the random number
      case "$choice" in
          0) wfetch --waifu2 --challenge --challenge-years=3 --image-size 300 ;;
          1) wfetch --waifu --challenge --challenge-years=3 --image-size 300 ;;
          2) wfetch --challenge --challenge-years=3 --hollow ;;
          3) wfetch --challenge --challenge-years=3 --wallpaper ;;
          4) wfetch --challenge --challenge-years=3 --smooth ;;
      esac
    '')


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
    element
    eza
    fastfetch
    findutils
    ffmpeg
    fd
    feh
    file-roller
    jq
    gcc
    git
    glib # for gsettings to work
    gnumake
    grim
        #gtk-engine-murrine # for gtk themes
        #gnome-system-monitor
    inxi
    imagemagick
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
    uwsm  # wayland session mgr
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
    pika-backup
    pipes
    pipes-rs
    ripgrep
    socat
    starship
    tldr
    ugrep
    unrar
    v4l-utils
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
    hyprcursor
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
