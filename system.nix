{
  inputs,
  config,
  pkgs,
  username,
  hostname,
  ...
}: let
  inherit
    (import ./options.nix)
    theLocale
    theTimezone
    gitUsername
    theShell
    wallpaperDir
    wallpaperGit
    theLCVariables
    theKBDLayout
    flakeDir
    theme
    ;
in {
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
  time.timeZone = "${theTimezone}";

  # Select internationalisation properties
  i18n.defaultLocale = "${theLocale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${theLCVariables}";
    LC_IDENTIFICATION = "${theLCVariables}";
    LC_MEASUREMENT = "${theLCVariables}";
    LC_MONETARY = "${theLCVariables}";
    LC_NAME = "${theLCVariables}";
    LC_NUMERIC = "${theLCVariables}";
    LC_PAPER = "${theLCVariables}";
    LC_TELEPHONE = "${theLCVariables}";
    LC_TIME = "${theLCVariables}";
  };

  console.keyMap = "${theKBDLayout}";

  # Define a user account.
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      hashedPassword = "$6$YdPBODxytqUWXCYL$AHW1U9C6Qqkf6PZJI54jxFcPVm2sm/XWq3Z1qa94PFYz0FF.za9gl5WZL/z/g4nFLQ94SSEzMg5GMzMjJ6Vd7.";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = ["networkmanager" "wireshark" "wheel" "libvirtd" "libvirt" "kvm" "qemu-libvirtd" "video" "render"];
      shell = pkgs.${theShell};
      ignoreShellProgramCheck = true;
      packages = with pkgs; [];
    };
  };

  environment.variables = {
    VAGRANT_DEFAULT_PROVIDER = "libvirt";
    FLAKE = "${flakeDir}";
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
