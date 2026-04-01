{
  pkgs,
  config,
  username,
  inputs,
  osConfig,
  ...
}: {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${osConfig.mySystem.browser}"
    claude-code
    chromium
    firefox
    wrangler
    # discord
    libvirt
    swww
    grim
    slurp
    pkgs.file-roller
    swaynotificationcenter
    rofi
    imv
    transmission_4-gtk
    mpv
    #gimp
    obs-studio
    rustup
    # audacity # Temporarily disabled due to RapidJSON build issue
    pavucontrol
    tree
    font-awesome
    spotify
    neovide
    cliphist
    wl-clip-persist
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
    #vagrant
    google-cloud-sdk
    espeak
    #warp-terminal

    # Import Scripts
    (import ./../scripts/emopicker9000.nix {inherit pkgs;})
    (import ./../scripts/task-waybar.nix {inherit pkgs;})
    (import ./../scripts/squirtle.nix {inherit pkgs;})
    (import ./../scripts/wallsetter.nix {
      inherit pkgs;
      wallpaperDir = osConfig.mySystem.wallpaperDir;
      inherit username;
      wallpaperGit = osConfig.mySystem.wallpaperGit;
    })
    (import ./../scripts/themechange.nix {
      inherit pkgs;
      flakeDir = osConfig.mySystem.flakeDir;
    })
    (import ./../scripts/theme-selector.nix {inherit pkgs;})
    (import ./../scripts/nvidia-offload.nix {inherit pkgs;})
    (import ./../scripts/web-search.nix {inherit pkgs;})
    (import ./../scripts/rofi-launcher.nix {inherit pkgs;})
    (import ./../scripts/screenshootin.nix {inherit pkgs;})
    (import ./../scripts/list-hypr-bindings.nix {
      inherit pkgs;
      terminal = osConfig.mySystem.terminal;
      browser = osConfig.mySystem.browser;
    })
  ];

  programs.gh.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
