{ config, lib, pkgs, ... }:

lib.mkIf (config.mySystem.theKernel == "zen") {
  boot.kernelPackages = pkgs.linuxPackages_zen;
}
