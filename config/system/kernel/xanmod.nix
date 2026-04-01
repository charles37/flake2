{ config, lib, pkgs, ... }:

lib.mkIf (config.mySystem.theKernel == "xanmod") {
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
}
