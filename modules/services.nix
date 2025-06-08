{ pkgs, ...}: {

    services = {

    libinput.enable = true; # Input Handling
    envfs.enable = true;
    fstrim.enable = true; # SSD Optimizer
    gvfs.enable = true; # For Mounting USB & More
    openssh = {
      enable = true; # Enable SSH
      settings = {
        PermitRootLogin = "no"; # Prevent root from SSH login
        PasswordAuthentication = true; #Users can SSH using kb and password
        KbdInteractiveAuthentication = true;
      };
      ports = [22];
    };

    tumbler.enable = true; # Image/video preview
    gnome.gnome-keyring.enable = true;

    # Enable flatpak and add repo
    flatpak.enable = true;
       # NFS 
    rpcbind.enable = true;
    nfs.server.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  #};

   displayManager.sddm = {
      enable = false;
      theme = "elarun";
      wayland.enable = true;
      extraPackages = with pkgs; [
        sddm
        kdePackages.sddm
        libsForQt5.qt5.qtgraphicaleffects
        where-is-my-sddm-theme
      ];
    };


  };
     systemd.services.flatpak-repo = {
    path = [pkgs.flatpak];
    script = ''
          flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            '';
    };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };


}
