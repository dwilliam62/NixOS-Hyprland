{
  pkgs,
  inputs,
  unstable,
  ...
}: {

  programs = {
     hyprland = {
      enable = true;
      withUWSM = true;
     	  #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
		    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; #xdph-git
     	  
        portalPackage = pkgs.xdg-desktop-portal-hyprland; # xdph none git
  	  xwayland.enable = true;
    };
    zsh.ohMyZsh.enable = true;
	waybar.enable = true;
	hyprlock.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
       git.enable = true;
       tmux.enable = true;
       nm-applet.indicator = true;
       neovim = {
          enable = true;
          defaultEditor = true;
       };
        xwayland.enable = true;
        niri = {
          enable = true;
          package = pkgs.niri;
        };
    };

    services.xserver = {
        enable = true;
        displayManager.startx.enable = true; 
    };


  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [

    # Start gnome polkit needed for niri
     (writeShellScriptBin "start-polkit-agent" ''
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    '')
  
    # Your fastfetch script
    (pkgs.writeShellScriptBin "ff" ''
      fastfetch -c ~/.config/fastfetch/fastfetch-system-times.config.jsonc
    '')

    # Update flkake script
    (pkgs.writeShellScriptBin "fupdate" ''
    cd ~/NixOS-Hyprland
     nh os switch -u -H {$hostname} flake.nix
    '')

    # Rebuild flkake script
    (pkgs.writeShellScriptBin "frebuild" ''
    cd ~/NixOS-Hyprland
     nh os switch -H {$hostname} flake.nix
    '')

    # clean up old generations 
     (writeShellScriptBin "ncg" 
     ''
        nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot
    '')

    # start Niri script
    (pkgs.writeShellScriptBin "niri.startup" ''

        #variety &
        xwayland-satellite >/dev/null 2>/dev/null & 
        waypaper --restore &
        SCRIPTSDIR=$HOME/.config/niri/scripts

        sleep 0.5 
        waybar &

         #  ~/.config/niri/scripts/statusbar &

            # Apply themes
            ~/.config/niri/scripts/gtkthemes-manual &

            # Launch notification daemon (mako)
            ~/.config/niri/scripts/notifications &

            # Launch statusbar (waybar)
            ~/.config/niri/scripts/statusbar &

             nm-applet --indicator &

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

  ### Xorg Stuff ###
    xorg.xinit
    xorg.xinput
    xorg.xauth

 # Hyprland Stuff
    hypridle
    hyprpolkitagent
    pyprland
    uwsm
    hyprpanel
    matugen #for Hyprpanel

    
    appimage-run
    bottom
    cmatrix
    dua
    figlet
    google-chrome
    bc
    brightnessctl
    btrfs-progs
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
    killall  
    gcc
    git
    glib # for gsettings to work
    gnumake
    grim
    grimblast
    gsettings-qt
    gtk-engine-murrine # for gtk themes
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
    neohtop
    nethogs
    networkmanagerapplet
    nitrogen
        #nvtopPackages.full
    pamixer
    pavucontrol
    playerctl
        #polkit
    polkit_gnome
        #kdePackages.polkit-kde-agent-1
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
    caligula  #burn ISOs at cli FAST
    astroterm  #constilations at CLI 
    atop
    gdu
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
    oh-my-posh
    pastel
    pika-backup
    pipes
    pipes-rs
    pfetch
    ncdu
    ncftp
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
    mission-center
    neofetch
    pfetch
    powertop
    stacer

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
    shellcheck
    shfmt
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
        #tmux
    wezterm

    # Hyprland related
    hyprpolkitagent
    hyprlang
        #hyprshot
    hyprcursor
    mesa
    nwg-drawer
    nwg-hello
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
