{...}: {
  mySystem = {
    # User identity
    username = "ben";
    hostname = "nora";
    gitUsername = "charles37";
    gitEmail = "benprevor@gmail.com";

    # Appearance
    theme = "3024";
    waybarStyle = "simplebar";
    bar-number = true;
    borderAnim = true;

    # Applications
    browser = "qutebrowser";
    terminal = "kitty";

    # Wallpaper
    wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git";

    # System settings
    clock24h = false;
    theLocale = "en_US.UTF-8";
    theKBDLayout = "us";
    theSecondKBDLayout = "de";
    theKBDVariant = "";
    theLCVariables = "en_US.UTF-8";
    theTimezone = "America/New_York";
    theShell = "fish";
    theKernel = "zen";
    sdl-videodriver = "wayland";

    # Hardware
    cpuType = "amd";
    gpuType = "amd";
    intel-bus-id = "PCI:0:2:0";
    nvidia-bus-id = "PCI:14:0:0";

    # NFS
    nfs = false;
    nfsMountPoint = "/mnt/nas";
    nfsDevice = "nas:/volume1/nas";

    # Feature toggles
    ntp = true;
    localHWClock = false;
    printer = false;
    distrobox = false;
    flatpak = false;
    kdenlive = false;
    blender = false;
    logitech = true;
    python = false;
    syncthing = false;

    # Terminal emulators
    wezterm = false;
    alacritty = false;
    kitty = true;
  };
}
