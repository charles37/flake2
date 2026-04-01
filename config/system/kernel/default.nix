{ config, lib, pkgs, ... }:

lib.mkIf (config.mySystem.theKernel == "default") {
  boot.kernelPackages = pkgs.linuxPackages;
}
