{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Enable &/ Configure Programs
    ./alacritty.nix
    ./bash.nix
    ./gtk-qt.nix
    ./hyprland.nix
    ./kdenlive.nix
    ./kitty.nix
    ./iamb.nix
    ./neofetch.nix
    ./nushell.nix
    ./packages.nix
    ./rofi.nix
    ./starship.nix
    ./tmux.nix
    ./waybar.nix
    ./wlogout.nix
    ./swappy.nix
    ./swaylock.nix
    ./swaync.nix
    ./wezterm.nix
    ./zsh.nix
    ./qutebrowser.nix
    # Place Home Files Like Pictures
    ./files.nix
  ];
}
