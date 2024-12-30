{
  pkgs,
  config,
  username,
  inputs,
  ...
}: let
  inherit
    (import ../../options.nix)
    browser
    wallpaperDir
    wallpaperGit
    flakeDir
    ;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    chromium
    firefox
    discord
    libvirt
    swww
    grim
    slurp
    pkgs.file-roller
    swaynotificationcenter
    rofi-wayland
    imv
    transmission-gtk
    mpv
    gimp
    obs-studio
    rustup
    audacity
    pavucontrol
    tree
    font-awesome
    spotify
    swayidle
    neovide
    swaylock
    #(nerdfonts.override {fonts = ["JetBrainsMono"];})
    #     ┃        error: nerdfonts has been separated into individual font packages under the namespace nerd-fonts.
    # ┃            For example change:
    # ┃              fonts.packages = [
    # ┃                ...
    # ┃                (pkgs.nerdfonts.override { fonts = [ "0xproto" "DroidSansMono" ]; })
    # ┃              ]
    # ┃            to
    # ┃              fonts.packages = [
    # ┃                ...
    # ┃                pkgs.nerd-fonts._0xproto
    # ┃                pkgs.nerd-fonts.droid_sans_mono
    # ┃              ]
    # ┃            or for all fonts
    # ┃              font.packages = [ ... ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)

    pkgs.nerd-fonts.jetbrains-mono
    #Bens packages
    signal-desktop
    git-credential-manager
    zoom-us
    #libreoffice-still
    pika-backup
    evince
    # chromium
    figma-linux
    lazygit
    #swiPrologWithGui
    speechd
    wl-color-picker
    obsidian
    diffutils
    slack
    vagrant
    whatsapp-for-linux
    google-cloud-sdk
    #warp-terminal

    inputs.nixvim.packages."x86_64-linux".default

    # Import Scripts
    (import ./../scripts/emopicker9000.nix {inherit pkgs;})
    (import ./../scripts/task-waybar.nix {inherit pkgs;})
    (import ./../scripts/squirtle.nix {inherit pkgs;})
    (import ./../scripts/wallsetter.nix {
      inherit pkgs;
      inherit wallpaperDir;
      inherit username;
      inherit wallpaperGit;
    })
    (import ./../scripts/themechange.nix {
      inherit pkgs;
      inherit flakeDir;
    })
    (import ./../scripts/theme-selector.nix {inherit pkgs;})
    (import ./../scripts/nvidia-offload.nix {inherit pkgs;})
    (import ./../scripts/web-search.nix {inherit pkgs;})
    (import ./../scripts/rofi-launcher.nix {inherit pkgs;})
    (import ./../scripts/screenshootin.nix {inherit pkgs;})
    (import ./../scripts/list-hypr-bindings.nix {inherit pkgs;})
  ];

  programs.gh.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
