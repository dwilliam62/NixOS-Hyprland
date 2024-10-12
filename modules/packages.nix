{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [


     # My programs
    (inputs.wezterm.packages.${pkgs.system}.default)
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
    remina
    ripgrep
    smartmontools
    socat                                                                                 
    stacer                                                                                
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

