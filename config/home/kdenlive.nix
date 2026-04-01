{ pkgs, config, lib, osConfig, ... }:

lib.mkIf (osConfig.mySystem.kdenlive == true) {
  home.packages = with pkgs; [
    pkgs.kdenlive
  ];
}
