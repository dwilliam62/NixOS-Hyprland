{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # My programs
    (inputs.wezterm.packages.${pkgs.system}.default)
    (inputs.hyprpanel.packages.${pkgs.system}.default)

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

    alacritty
    alejandra
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
    discord
    dua
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
    #  End
    gcc
    git
    github-desktop
    glances
    #google-chrome
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
    ironbar #waybar replacement
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
    mc
    meld
    meson
    mission-center
    ncdu
    ncftp
    nixpkgs-fmt
    nixd
    nixfmt-rfc-style
    nodejs_22
    neofetch
    neovide
    neovim
    nh
    nix-ld
    nomachine-client
    nomacs
    nvtopPackages.full
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
    xclip
    yad
    yazi
    zed-editor
    zellij
    zig
    zoxide
  ];
  # Added per VIMjoyner vidoe on setting up nixd
  nix.nixPath = ["nixpkgs = ${inputs.nixpkgs}"];
}
