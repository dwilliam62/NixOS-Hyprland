# Main default config

{ config, pkgs, host, username, options, lib, inputs, system, ...}: let
    inherit (import ./variables.nix) keyboardLayout;
    python-packages = pkgs.python3.withPackages (
      ps:
        with ps; [
          requests
          pyquery # needed for hyprland-dots Weather script
        ]
  	  );
  in {
  imports = [
    ./hardware.nix
    ./users.nix
    ../../modules/amd-drivers.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    ../../modules/packages.nix
  ];

  # BOOT related stuff
  boot = {
    kernelPackages = pkgs.linuxPackages; # Kernel

    kernelParams = [
    	"systemd.mask=systemd-vconsole-setup.service"
    	"systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog" 
	   	"modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
 	  ];

    # This is for OBS Virtual Cam Support
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    
    initrd = { 
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };

    # Needed For Some Steam Games
    #kernel.sysctl = {
    #  "vm.max_map_count" = 2147483642;
    #};

    ## BOOT LOADERS: NOT USE ONLY 1. either systemd or grub  
    # Bootloader SystemD
    loader.systemd-boot.enable = true;
  
    loader.efi = {
	    #efiSysMountPoint = "/efi"; #this is if you have separate /efi partition
	    canTouchEfiVariables = true;
  	  };

    loader.timeout = 1;    
  			
    # Bootloader GRUB
    #loader.grub = {
	    #enable = true;
	    #  devices = [ "nodev" ];
	    #  efiSupport = true;
      #  gfxmodeBios = "auto";
	    #memtest86.enable = true;
	    #extraGrubInstallArgs = [ "--bootloader-id=${host}" ];
	    #configurationName = "${host}";
  	  #	};

    # Bootloader GRUB theme  
    #loader.grub = rec {
    #  theme = inputs.distro-grub-themes.packages.${system}.nixos-grub-theme;
    #  splashImage = "${theme}/splash_image.jpg";
      #};
    ## -end of BOOTLOADERS----- ##
  
    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
      };
    
    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
      };
    plymouth.enable = true;
  };

  # Extra Module Options
  drivers.amdgpu.enable = false;
  drivers.nvidia.enable = false;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "";
    nvidiaBusID = "";
  };
  drivers.intel.enable = false;
  vm.guest-services.enable = true;
  local.hardware-clock.enable = false;

  # networking
  networking.networkmanager.enable = true;
  networking.hostName = "${host}";
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  programs = {
	  hyprland = {
      enable = true;
		  package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
		  portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; # xdphls
  	  };

	xwayland.enable = true;

	waybar.enable = true;
	hyprlock.enable = true;
	firefox.enable = false;
	git.enable = true;

	thunar.enable = true;
	thunar.plugins = with pkgs.xfce; [
		exo
		mousepad
		thunar-archive-plugin
		thunar-volman
		tumbler
  	];
	
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = false;
    
    #steam = {
    #  enable = true;
    #  gamescopeSession.enable = true;
    #  remotePlay.openFirewall = true;
    #  dedicatedServer.openFirewall = true;
    #};
	
  };

  nixpkgs.config.allowUnfree = true;

  users = {
    mutableUsers = true;
  };

  environment.systemPackages = (with pkgs; [
  # System Packages
  #  override for aquamarine 
           (aquamarine.overrideAttrs (oldAttrs: {
          inherit (oldAttrs) pname;
         version = "0.4.5";
         }))

   #   override for hyprland 
               (hyprland.overrideAttrs (oldAttrs: {
        inherit (oldAttrs) pname;
         version = "0.45.0";
          }))
    
    #waybar  # if wanted experimental next line
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [
	  python-packages
  ];

  # FONTS
  fonts.packages = with pkgs; [
        # Moved to system.packages.nix
    #noto-fonts
    #fira-code
    #noto-fonts-cjk-sans
        #jetbrains-mono
        #font-awesome
        #  terminus_font
        #  (nerdfonts.override {fonts = ["JetBrainsMono"];})
 	];

    # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      #pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

  # Services to start
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };
    
    greetd = {
      enable = false;
      vt = 3;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu --time --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=cyan;container=blue;input=red' --cmd Hyprland"; 
        };
      };
    };

      displayManager.sddm = {
      enable = true;
      theme = "elarun";
      wayland.enable = true;
      extraPackages = with pkgs; [
          sddm 
          kdePackages.sddm
          libsForQt5.qt5.qtgraphicaleffects
          where-is-my-sddm-theme
      ];
    };
    
    smartd = {
      enable = false;
      autodetect = true;
    };
    
    envfs.enable = true;
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
    
    #printing = {
    #  enable = false;
    #  drivers = [
        # pkgs.hplipWithPlugin
    #  ];
    #};
    
    gnome.gnome-keyring.enable = true;
    
    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};
    
    #ipp-usb.enable = true;
    
    #syncthing = {
    #  enable = false;
    #  user = "${username}";
    #  dataDir = "/home/${username}";
    #  configDir = "/home/${username}/.config/syncthing";
    #};
    
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    rpcbind.enable = true;
    nfs.server.enable = true;
  };
  
  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  
  #hardware.sane = {
  #  enable = true;
  #  extraBackends = [ pkgs.sane-airscan ];
  #  disabledDefaultBackends = [ "escl" ];
  #};

  # Extra Logitech Support
  hardware.logitech.wireless.enable = false;
  hardware.logitech.wireless.enableGraphical = false;

  # Bluetooth Support
  hardware.bluetooth.enable = false;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = false;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.swaylock = {
    text = ''
      auth include login
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
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # OpenGL
  hardware.graphics = {
    enable = true;
  };

  console.keyMap = "${keyboardLayout}";

   security.sudo = { 
   enable = true;
   extraRules = [ 
    {
       users = [ "dwilliams" ];
       commands = [
         {
           command = "ALL";
           options = [ "NOPASSWD" ];
         }
        ];
     }
   ];
  };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
