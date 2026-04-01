{ config, lib, pkgs, ... }:

lib.mkIf (config.mySystem.theKernel == "lqx") {
  boot.kernelPackages = pkgs.linuxPackages_lqx;
}
