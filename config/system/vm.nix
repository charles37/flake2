{ pkgs, config, lib, ... }:

lib.mkIf (config.mySystem.cpuType == "vm") {
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;
}
