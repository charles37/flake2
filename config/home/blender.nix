{ pkgs, config, lib, osConfig, ... }:

lib.mkIf (osConfig.mySystem.blender == true) {
  home.packages = with pkgs; [
    pkgs.blender-hip
  ];
}
