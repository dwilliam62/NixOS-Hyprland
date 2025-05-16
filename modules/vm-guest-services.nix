# 💫 https://github.com/JaKooLit 💫 #

{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.vm.guest-services;
in
{
  options.vm.guest-services = {
    enable = mkEnableOption "Enable Virtual Machine Guest Services";
  };

  config = mkIf cfg.enable {
    services = {
        qemuGuest.enable = true;
        spice-vdagentd.enable = true;
        spice-webdavd.enable = true;
    };
  };
}
