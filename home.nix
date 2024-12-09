{
  config,
  pkgs,
  inputs,
  username,
  gtkThemeFromScheme,
  ...
}: let
  inherit
    (import ./options.nix)
    gitUsername
    gitEmail
    theme
    browser
    wallpaperDir
    wallpaperGit
    flakeDir
    waybarStyle
    ;
in {
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05"; # To Be Updated

  # Set The Colorscheme
  colorScheme = inputs.nix-colors.colorSchemes."${theme}";

  # Import Program Configurations
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    ./config/home
  ];

  # Define Settings For Xresources
  xresources.properties = {
    "Xcursor.size" = 24;
  };

  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
    lfs.enable = true;
    extraConfig = {
      credential = {
        helper = "manager";
        "https://github.com".username = "${gitUsername}";
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

  programs.home-manager.enable = true;
}
