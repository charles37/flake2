# For the adventurous people
# It's not listed in the list of possible options,
# but the ones who want to try it can do so.
{ config, lib, pkgs, ... }:

lib.mkIf (config.mySystem.theKernel == "testing") {
  boot.kernelPackages = pkgs.linuxPackages_testing;
}
