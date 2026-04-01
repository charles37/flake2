{ config, lib, ... }:

lib.mkIf config.mySystem.nfs {
  fileSystems."${config.mySystem.nfsMountPoint}" = {
    device = config.mySystem.nfsDevice;
    fsType = "nfs";
  };
  services = {
    rpcbind.enable = true;
    nfs.server.enable = true;
  };
}
