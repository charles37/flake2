{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}:
  lib.mkIf (osConfig.mySystem.wezterm
    == false
    && osConfig.mySystem.alacritty == false
    || osConfig.mySystem.kitty == true) {
    # Configure Kitty (colors managed by stylix)
    programs.kitty = {
      enable = true;
      package = pkgs.kitty;
      font = {
        name = lib.mkForce "TX-02";
        size = lib.mkForce 16;
      };
      settings = {
        scrollback_lines = 2000;
        wheel_scroll_min_lines = 1;
        window_padding_width = 4;
        confirm_os_window_close = 0;
        background_opacity = lib.mkForce "0.85";
      };
      extraConfig = ''
        tab_bar_style fade
        tab_fade 1
      '';
      shellIntegration.enableFishIntegration = true;
    };
  }
