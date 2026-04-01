{ config, lib, pkgs, ... }:

lib.mkIf config.mySystem.distrobox {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  environment.systemPackages = [pkgs.distrobox];
}
