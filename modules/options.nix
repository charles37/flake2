{
  config,
  lib,
  ...
}: let
  cfg = config.mySystem;
in {
  options.mySystem = {
    # Identity
    username = lib.mkOption {
      type = lib.types.str;
      description = "Primary user account name";
    };
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "System hostname";
    };
    userHome = lib.mkOption {
      type = lib.types.str;
      default = "/home/${cfg.username}";
      description = "User home directory path";
    };

    # Git
    gitUsername = lib.mkOption {
      type = lib.types.str;
      description = "Git username";
    };
    gitEmail = lib.mkOption {
      type = lib.types.str;
      description = "Git email address";
    };

    # Appearance
    theme = lib.mkOption {
      type = lib.types.str;
      default = "3024";
      description = "Base16 color scheme name";
    };
    waybarStyle = lib.mkOption {
      type = lib.types.enum ["simplebar" "slickbar" "default"];
      default = "simplebar";
      description = "Waybar style variant";
    };
    bar-number = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Show workspace numbers in waybar";
    };
    borderAnim = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable animated border in Hyprland";
    };

    # Applications
    browser = lib.mkOption {
      type = lib.types.str;
      default = "qutebrowser";
      description = "Default browser package name";
    };
    terminal = lib.mkOption {
      type = lib.types.str;
      default = "kitty";
      description = "Default terminal emulator";
    };

    # Wallpaper
    wallpaperGit = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Git repo URL for wallpapers";
    };
    wallpaperDir = lib.mkOption {
      type = lib.types.str;
      default = "${cfg.userHome}/Pictures/Wallpapers";
      description = "Local wallpaper directory";
    };
    screenshotDir = lib.mkOption {
      type = lib.types.str;
      default = "${cfg.userHome}/Pictures/Screenshots";
      description = "Screenshot save directory";
    };

    # Flake paths
    flakeDir = lib.mkOption {
      type = lib.types.str;
      default = "${cfg.userHome}/flake2";
      description = "Flake directory path";
    };
    flakePrev = lib.mkOption {
      type = lib.types.str;
      default = "${cfg.userHome}/.zaneyos-previous";
      description = "Previous flake backup path";
    };
    flakeBackup = lib.mkOption {
      type = lib.types.str;
      default = "${cfg.userHome}/.zaneyos-backup";
      description = "Flake backup directory";
    };

    # System settings
    clock24h = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use 24-hour clock format";
    };
    theLocale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "System locale";
    };
    theKBDLayout = lib.mkOption {
      type = lib.types.str;
      default = "us";
      description = "Primary keyboard layout";
    };
    theSecondKBDLayout = lib.mkOption {
      type = lib.types.str;
      default = "de";
      description = "Secondary keyboard layout";
    };
    theKBDVariant = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Keyboard variant";
    };
    theLCVariables = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "LC environment variables locale";
    };
    theTimezone = lib.mkOption {
      type = lib.types.str;
      default = "America/New_York";
      description = "System timezone";
    };
    theShell = lib.mkOption {
      type = lib.types.enum ["bash" "zsh" "nushell" "fish"];
      default = "fish";
      description = "Default user shell";
    };
    theKernel = lib.mkOption {
      type = lib.types.enum ["default" "latest" "lqx" "xanmod" "zen" "testing"];
      default = "zen";
      description = "Linux kernel variant";
    };
    sdl-videodriver = lib.mkOption {
      type = lib.types.enum ["wayland" "x11"];
      default = "wayland";
      description = "SDL video driver backend";
    };

    # Hardware
    cpuType = lib.mkOption {
      type = lib.types.str;
      default = "amd";
      description = "CPU type (amd, intel, vm)";
    };
    gpuType = lib.mkOption {
      type = lib.types.str;
      default = "amd";
      description = "GPU type (amd, nvidia, intel, intel-nvidia, intel-amd)";
    };
    intel-bus-id = lib.mkOption {
      type = lib.types.str;
      default = "PCI:0:2:0";
      description = "Intel GPU PCI bus ID (for hybrid systems)";
    };
    nvidia-bus-id = lib.mkOption {
      type = lib.types.str;
      default = "PCI:14:0:0";
      description = "NVIDIA GPU PCI bus ID (for hybrid systems)";
    };

    # NFS
    nfs = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NFS mounting";
    };
    nfsMountPoint = lib.mkOption {
      type = lib.types.str;
      default = "/mnt/nas";
      description = "NFS mount point";
    };
    nfsDevice = lib.mkOption {
      type = lib.types.str;
      default = "nas:/volume1/nas";
      description = "NFS device path";
    };

    # Feature toggles
    ntp = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable NTP time sync";
    };
    localHWClock = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use local hardware clock";
    };
    printer = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable printer and scanner support";
    };
    distrobox = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable distrobox/podman";
    };
    flatpak = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Flatpak support";
    };
    kdenlive = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Kdenlive video editor";
    };
    blender = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Blender 3D";
    };
    logitech = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Logitech device support";
    };
    python = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Python and PyCharm";
    };
    syncthing = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Syncthing file sync";
    };

    # Terminal emulator toggles
    wezterm = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable WezTerm terminal";
    };
    alacritty = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Alacritty terminal";
    };
    kitty = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Kitty terminal";
    };
  };

  # Derived values
  config.mySystem = {
    # These are computed from waybarStyle — not set by the user directly
  };
}
