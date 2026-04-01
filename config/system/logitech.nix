{ pkgs, config, lib, ... }:

lib.mkIf config.mySystem.logitech {
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
}
