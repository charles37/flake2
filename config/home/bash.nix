{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir flakePrev 
	     hostname flakeBackup theShell; in
lib.mkIf (theShell == "bash") {
  # Configure Bash
  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #  exec Hyprland
      #fi
    '';
    initExtra = ''
      neofetch
      if [ -f $HOME/.bashrc-personal ]; then
        source $HOME/.bashrc-personal
      fi
    '';
    sessionVariables = {
      ZANEYOS = true;
      FLAKEBACKUP = "${flakeBackup}";
      FLAKEPREV = "${flakePrev}";
    };
    shellAliases = {
      sv="sudo nvim";
      flake-rebuild="nh os switch --hostname ${hostname}";
      #flake-rebuild="nh os switch --hostname ${hostname}";
      flake-update="nh os switch --hostname ${hostname} --update";
      #flake-update="nh os switch -- --nom --hostname ${hostname} --update";
      gcCleanup="nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      v="nvim";
      ls="lsd";
      ll="lsd -l";
      la="lsd -a";
      lal="lsd -al";
      ".."="cd ..";
      neofetch="neofetch --ascii ~/.config/ascii-neofetch";
       # Add the rebuild_nixos alias
      rebuild-nixos="
        set -e
        
        # Edit your config
        \$EDITOR flake.nix
        
        # cd to your config dir
        pushd ~/flake2/
        
        # Early return if no changes were detected
        if git diff --quiet flake.nix; then
            echo \"No changes detected, exiting.\"
            popd
            exit 0
        fi
        
        # Autoformat your nix files
        alejandra . &>/dev/null \\
            || ( alejandra . ; echo \"formatting failed!\" && exit 1)
        
        # Shows your changes
        git diff -U0 flake.nix
        
        echo \"NixOS Rebuilding...\"
        
        # Rebuild using flake, output simplified errors, log trackebacks
        sudo nixos-rebuild switch --flake .#nora &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)
        
        # Get current generation metadata
        current=\$(nixos-rebuild list-generations | grep current)
        
        # Commit all changes with the generation metadata
        git commit -am \"\$current\"
        
        # Back to where you were
        popd
        
        # Notify all OK!
        notify-send -e \"NixOS Rebuilt OK!\" --icon=software-update-available
      ";
    };
  };
}
