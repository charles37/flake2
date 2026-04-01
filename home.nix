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
      userName = "${osConfig.mySystem.gitUsername}";
      userEmail = "${osConfig.mySystem.gitEmail}";
      lfs.enable = true;
      extraConfig = {
        credential = {
          helper = "manager";
          "https://github.com".username = "${osConfig.mySystem.gitUsername}";
          credentialStore = "cache";
        };
        #credential.helper = "store";
        # credential.helper = "${
        #   pkgs.git.override {withLibsecret = true;}
        # }/bin/git-credential-libsecret";
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
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
