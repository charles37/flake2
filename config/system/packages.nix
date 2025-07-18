{
  pkgs,
  config,
  inputs,
  ...
}: {
  nixpkgs = {
    config = {
      # Allow unfree packages
      allowUnfree = true;

      permittedInsecurePackages = [
        # "adobe-reader-9.5.5"
        #"segger-jlink-qt4"
        #"segger-jlink-qt4-796b"
      ];

      #segger-jlink.acceptLicense = true;
    };

    overlays = [
      (import ./overlays.nix)
    ];
  };

  nix.settings.trusted-users = ["root" "ben"];

  # List System Programs
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    cmatrix
    lolcat
    neofetch
    htop
    btop
    libvirt
    polkit_gnome
    lm_sensors
    unzip
    unrar
    libnotify
    eza
    v4l-utils
    ydotool
    wl-clipboard
    socat
    cowsay
    lsd
    lshw
    pkg-config
    meson
    hugo
    gnumake
    ninja
    go
    nodejs
    symbola
    noto-fonts-color-emoji
    material-icons
    brightnessctl
    toybox
    virt-viewer
    swappy
    ripgrep
    appimage-run
    networkmanagerapplet
    yad
    playerctl
    nh
    openssl
    ghc
    qemu

    ### waybar dependency new
    wireplumber
    whatsie

    ###
    lean4
    monitor
    deepin.deepin-system-monitor
    gleam
    erlang
    rebar3
    zlib
    stack
    cabal-install
    openssl
    iamb
    element-desktop
    jq

    #qgis

    #MLIR
    #bazelisk

    # zero2prod
    doctl
    inputs.zig-overlay.packages.${pkgs.system}."0.14.0"
    ghostty
    claude-code

    #adobe-reader
    xorg.xhost
    clinfo
    libsecret
    wireshark
    burpsuite
    man-pages
    man-pages-posix
    #zluda
  ];

  programs = {
    steam.gamescopeSession.enable = true;
    dconf.enable = true;
    #seahorse.enable = true;
    nix-ld.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
    wireshark.enable = true;
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
      ovmf.packages = [
        (pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        })
        .fd
      ];
    };
  };
}
