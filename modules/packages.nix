{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [


     # My programs
    (inputs.wezterm.packages.${pkgs.system}.default)

    # Override for cliphis  Waiting for update to reach unstable bracnh
    #  10-16-24
    #  https://nixpk.gs/pr-tracker.html?pr=348887

    (cliphist.overrideAttrs (_old: {
      src = pkgs.fetchFromGitHub {
       owner = "sentriz";
       repo = "cliphist";
       rev = "c49dcd26168f704324d90d23b9381f39c30572bd";
       sha256 = "sha256-2mn55DeF8Yxq5jwQAjAcvZAwAg+pZ4BkEitP6S2N0HY=";
       };
        vendorHash = "sha256-M5n7/QWQ5POWE4hSCMa0+GOVhEDCOILYqkSYIGoy/l0=";
      }))

    alacritty                                                                             
    appimage-run                                                                          
    aquamarine                                                                            
    atop                                                                                  
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
    google-chrome                                                                         
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
    mc
    meld
    meson 
    mission-center                                                                        
    ncdu                                                                                  
    ncftp                                                                                 
    nodejs_22
    neofetch                                                                              
    neovide                                                                               
    neovim                                                                                
    nh                                                                                    
    nomachine-client                                                                      
    nomacs                                                                                
    nvtopPackages.full 
    nwg-drawer
    nwg-dock-hyprland
    nwg-launchers
    obs-studio
    okular                                                                                
    ouch
    pfetch
    ptyxis
    powertop
    putty                                                                                 
    quickemu                                                                              
    #quickgui                                                                             
    remmina
    ripgrep
    smartmontools
    socat                                                                                 
    stacer                                                                                
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
    wf-recorder                                                                           
    yad
    yazi                                                                                  
    zellij                                                                                
    zig                                                                                   
    zoxide                                                                               



  ];
}

