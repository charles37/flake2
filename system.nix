{
  inputs,
  config,
  pkgs,
  username,
  hostname,
  ...
}: {
  imports = [
    ./hardware.nix
    ./config/system
  ];

  # Enable networking
  networking = {
    hostName = "${hostname}"; # Define your hostname
    networkmanager.enable = true;

    #firewall.allowedTCPPorts = [80 8000 8080];

    #firewall.enable = true;
  };

  # Set your time zone
  time.timeZone = config.mySystem.theTimezone;

  # Select internationalisation properties
  i18n.defaultLocale = config.mySystem.theLocale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = config.mySystem.theLCVariables;
    LC_IDENTIFICATION = config.mySystem.theLCVariables;
    LC_MEASUREMENT = config.mySystem.theLCVariables;
    LC_MONETARY = config.mySystem.theLCVariables;
    LC_NAME = config.mySystem.theLCVariables;
    LC_NUMERIC = config.mySystem.theLCVariables;
    LC_PAPER = config.mySystem.theLCVariables;
    LC_TELEPHONE = config.mySystem.theLCVariables;
    LC_TIME = config.mySystem.theLCVariables;
  };

  console.keyMap = config.mySystem.theKBDLayout;

  # Define a user account.
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      hashedPasswordFile = config.sops.secrets."ben-password".path;
      isNormalUser = true;
      description = config.mySystem.gitUsername;
      extraGroups = ["networkmanager" "wireshark" "wheel" "libvirtd" "libvirt" "kvm" "qemu-libvirtd" "video" "render"];
      shell = pkgs.${config.mySystem.theShell};
      ignoreShellProgramCheck = true;
      packages = with pkgs; [];
    };
  };

  environment.variables = {
    VAGRANT_DEFAULT_PROVIDER = "libvirt";
    NH_FLAKE = config.mySystem.flakeDir;
    POLKIT_BIN = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };

  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://hyprland.cachix.org" "https://cache.iog.io" "https://cache.nixos.org"];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.stateVersion = "23.11";
}
