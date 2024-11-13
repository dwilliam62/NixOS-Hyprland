# Main default config
{
  config,
  pkgs,
  host,
  username,
  options,
  lib,
  inputs,
  system,
  ...
}: let
  inherit (import ./variables.nix) keyboardLayout;
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
      ]
  );
  #| |__   __ _ _ __ __| |_      ____ _ _ _____
  #| '_ \ / _` | '__/ _` \ \ /\ / / _` | '__/ _ \
  #| | | | (_| | | | (_| |\ V  V / (_| | | |  __/
  #|_| |_|\__,_|_|  \__,_| \_/\_/ \__,_|_|  \___|
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
    ../../modules/system.packages.nix
    ../../modules/packages.nix
  ];

  # BOOT related stuff
  # Select which kernel by uncommenting it and comment out the default which is latest kernel

  boot = {
    kernelPackages = pkgs.linuxPackages_latest; #Latest  Kernel
    #kernelPackages = pkgs.linuxPackages; #LTS Kernel
    #kernelPackages = pkgs.linuxPackages_zen; #Zen Kernel

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" # this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" # watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" # watchdog for Intel
    ];

    # This is for OBS Virtual Cam Support
    # Which is need to share screen in discord and other
    # Electron based apps

    kernelModules = ["v4l2loopback"];
    extraModulePackages = [config.boot.kernelPackages.v4l2loopback];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [];
    };

    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };

    ## BOOT LOADERS: NOT USE ONLY 1. either systemd or grub
    # Bootloader SystemD
    loader.systemd-boot.enable = true;

    loader.efi = {
      #efiSysMountPoint = "/efi"; #this is if you have separate /efi partition
      canTouchEfiVariables = true;
    };

    loader.timeout = 10;

    # Bootloader GRUB
    #loader.grub = {
    #enable = true;
    #  devices = [ "nodev" ];
    #  efiSupport = true;
    #  gfxmodeBios = "auto";
    #  memtest86.enable = true;
    #  extraGrubInstallArgs = [ "--bootloader-id=${host}" ];
    #  configurationName = "${host}";
    #	 };

    # Bootloader GRUB theme, configure below

    ## -end of BOOTLOADERS----- ##

    # Make /tmp a tmpfs
    #  Be cautions enableing this.
    #  If you make it too small rebuilds and upgrades will fail
    #  Suggest leaving this as FALSE unless you know what you
    #  are doing.

    tmp = {
      useTmpfs = false;
      tmpfsSize = "40%";
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

    # Tis is for the NIXOS splash screen on startup
    # Leavign this off rprevents a number of packages
    # from being installed and speeds up the boot process

    plymouth.enable = true;
  };

  # GRUB Bootloader theme. Of course you need to enable GRUB above.. duh!
  #distro-grub-themes = {
  #  enable = true;
  #  theme = "nixos";
  #};

  # Extra Module Options
  drivers.amdgpu.enable = true;
  drivers.intel.enable = true;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "";
    nvidiaBusID = "";
  };

  # zram
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  local.hardware-clock.enable = false;

  # networking
  networking.networkmanager.enable = true;
  networking.hostName = "${host}";
  networking.timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];

  # OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Checke hardrves for errors
  #  Disable when running in a VM
  # or on older hardrives.

  smartd = {
    enable = false;
    autodetect = true;
  };

  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  udev.enable = true;
  envfs.enable = true;
  dbus.enable = true;

  fstrim = {
    enable = true;
    interval = "weekly";
  };

  blueman.enable = true;

  # OpenRGB
  hardware.openrgb.enable = false;
  hardware.openrgb.motherboard = "amd";

  # Extra Logitech Support
  hardware.logitech.wireless.enable = false;
  hardware.logitech.wireless.enableGraphical = false;

  # Bluetooth
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  fwupd.enable = true;

  upower.enable = true;

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

  # ___  ___  / _| |___      ____ _ _ __ ___
  #/ __|/ _ \| |_| __\ \ /\ / / _` | '__/ _ \
  #\__ \ (_) |  _| |_ \ V  V / (_| | | |  __/
  #|___/\___/|_|  \__| \_/\_/ \__,_|_|  \___|

  # environmental.systemPackagespackages installs software for this host
  # only.  moduels/packaages.nix should be used for common
  # packages for all hosts.

  users = {
    mutableUsers = true;
  };

  environment.systemPackages =
    (with pkgs; [
      # System Packages
      gotop
      #waybar  # if wanted experimental next line
      #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
    ])
    ++ [
      python-packages
    ];

  # FONTS
  # Added here will only be installed on this host
  # # Use modelues/packages.nix for fonts you want on every host

  fonts.packages = with pkgs; [
    # Moved to systemPackages,nix
    #noto-fonts
    #fira-code
    #noto-fonts-cjk-sans
    # jetbrains-mono
    font-awesome
    #  terminus_font
    #(nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

  console.keyMap = "${keyboardLayout}";

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

  nixpkgs.config.allowUnfree = true;

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; # hyprland-git
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; # xdphls
      xwayland.enable = true; #enables xwayland in hyprland
    };

    xwayland.enable = true; # Enabled xwayland the package

    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  waybar.enable = true;
  hyprlock.enable = true;
  firefox.enable = true;
  git.enable = true;
  nm-applet.indicator = true;
  neovim.enable = true;

  thunar.enable = true;
  thunar.plugins = with pkgs.xfce; [
    exo
    mousepad
    thunar-archive-plugin
    thunar-volman
    tumbler
  ];

  steam = {
    enable = false;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  #\ \   / (_)_ __| |_ _   _  __ _| (_)______ _| |_(_) ___  _ __
  # \ \ / /| | '__| __| | | |/ _` | | |_  / _` | __| |/ _ \| '_ \
  #  \ V / | | |  | |_| |_| | (_| | | |/ / (_| | |_| | (_) | | | |
  #   \_/  |_|_|   \__|\__,_|\__,_|_|_/___\__,_|\__|_|\___/|_| |_|

  vm.guest-services.enable = false;
  virt-manager.enable = false;

  # Virtualization / Containers
  virtualisation.libvirtd.enable = false;
  virtualisation.podman = {
    enable = false;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = false;
  };

  # ___  ___ _ ____   _(_) ___ ___  ___
  #/ __|/ _ \ '__\ \ / / |/ __/ _ \/ __|
  #\__ \  __/ |   \ V /| | (_|  __/\__ \
  #|___/\___|_|    \_/ |_|\___\___||___/

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
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = username;
           # start Hyprland with a TUI login manager
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu --time --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red' --cm
d Hyprland";
        };
      };
    };

    flatpak.enable = true;
    systemd.services.flatpak-repo = {
      path = [pkgs.flatpak];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };

    gvfs.enable = true;
    tumbler.enable = true;

    libinput.enable = true;

    rpcbind.enable = true;
    nfs.server.enable = true;

    openssh.enable = true;

    gnome.gnome-keyring.enable = true;

    printing = {
      enable = true;
      drivers = [
        pkgs.hplipWithPlugin
      ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    ipp-usb.enable = true;

    syncthing = {
      enable = false;
      user = "${username}";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
    };
  };

  hardware.sane = {
    enable = false;
    extraBackends = [pkgs.sane-airscan];
    disabledDefaultBackends = ["escl"];
  };

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
  #_ __ (_)_  __
  #| '_ \| \ \/ /
  #| | | | |>  <
  #|_| |_|_/_/\_\

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
