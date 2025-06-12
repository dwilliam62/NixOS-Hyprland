{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
     initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
     initrd.kernelModules = [ ];
     kernelModules = [ "kvm-intel" ];
     extraModulePackages = [ ];
};

  fileSystems = {
    "/" =
    { device = "/dev/disk/by-uuid/df53ca92-7f8a-4acf-a944-7825f83618c6";
      fsType = "ext4";
    };

  "/boot" =
    { device = "/dev/disk/by-uuid/05CE-B879";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  "/mnt/nas" =
    { device = "192.168.40.11:/volume1/DiskStation54TB";
      fsType = "nfs";
      options = [ "rw" "bg" "tcp" "_netdev"  ];
    };
 };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/dac7a165-475c-44be-8238-32ab04533e0c"; }
    ];

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s20u1u3.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
