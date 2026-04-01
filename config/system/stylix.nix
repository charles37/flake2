{pkgs, config, ...}: {
  stylix = {
    enable = true;
    image = ../../config/home/files/media/swaylock-bg.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.mySystem.theme}.yaml";
    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.ubuntu-classic;
        name = "Ubuntu";
      };
      serif = {
        package = pkgs.ubuntu-classic;
        name = "Ubuntu";
      };
      sizes = {
        applications = 12;
        terminal = 16;
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };

  # Disable stylix auto-theming for programs with custom configs (HM-level targets)
  home-manager.sharedModules = [
    {
      stylix.targets = {
        nixvim.enable = false;
        vim.enable = false;
        rofi.enable = false;
        waybar.enable = false;
        starship.enable = false;
        hyprpaper.enable = false;
      };
    }
  ];
}
