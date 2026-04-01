{
  config,
  pkgs,
  inputs,
  username,
  osConfig,
  ...
}: {
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05"; # To Be Updated

  # Import Program Configurations
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./config/home
  ];

  # Define Settings For Xresources
  xresources.properties = {
    "Xcursor.size" = 24;
  };

  programs = {
    # Install & Configure Git
    git = {
      enable = true;
      lfs.enable = true;
      signing.format = null;
      settings = {
        user = {
          name = osConfig.mySystem.gitUsername;
          email = osConfig.mySystem.gitEmail;
        };
        credential = {
          helper = "manager";
          "https://github.com".username = osConfig.mySystem.gitUsername;
          credentialStore = "cache";
        };
        lfs.fetchexclude = "*";
        lfs."https://www.github.com/charles37/big_money.git/info/lfs".locksverify = true;
      };
    };

    home-manager.enable = true;
  };

  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
