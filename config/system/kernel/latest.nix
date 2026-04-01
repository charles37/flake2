{ config, lib, pkgs, ... }:

lib.mkIf (config.mySystem.theKernel == "latest") {
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
