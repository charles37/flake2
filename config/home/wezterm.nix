{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}:
  lib.mkIf (osConfig.mySystem.wezterm == true) {
    home.packages = with pkgs; [
      pkgs.wezterm
    ];

    # Colors managed by stylix
    home.file.".config/wezterm/wezterm.lua".text = ''
      local wezterm = require 'wezterm'

      local config = wezterm.config_builder()

      wezterm.font_with_fallback({
        "JetBrains Mono",
        "Symbols Nerd Font Mono",
        "Noto Color Emoji",
      })

      return config
    '';
  }
