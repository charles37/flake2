{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit
    (import ../../options.nix)
    flakeDir
    flakePrev
    hostname
    flakeBackup
    theShell
    ;
in
  lib.mkIf (theShell == "fish") {
    programs.fish = {
      enable = true;

      # Typically fish completions “just work”, but you can set this if needed.
      enableCompletion = true;

      # This is the fish equivalent of Bash's `profileExtra` + `initExtra`.
      interactiveShellInit = ''
        # Print a splash, just like in your Bash example:
        neofetch

        #
        # Export environment variables (equivalent to `sessionVariables`).
        #
        # “-x” means export, so the variable is available to child processes.
        #
        set -x ZANEYOS true
        set -x FLAKEBACKUP ${flakeBackup}
        set -x FLAKEPREV ${flakePrev}

        #
        # If you want to source a personal fish config, rename or adapt
        # ~/.bashrc-personal into fish syntax or place it in ~/.config/fish/conf.d
        #
        # For demonstration, let's assume you have ~/.fishrc-personal
        # that is valid fish code:
        if test -f $HOME/.fishrc-personal
          source $HOME/.fishrc-personal
        end

        #
        # Define shell aliases. In fish 3.x, you can simply do:
        #
        alias sv 'sudo nvim'
        alias flake-rebuild "nh os switch --hostname ${hostname}"
        alias flake-update "nh os switch --hostname ${hostname} --update"
        alias gcCleanup 'nix-collect-garbage --delete-old; and sudo nix-collect-garbage -d; and sudo /run/current-system/bin/switch-to-configuration boot'
        alias v "nvim"
        alias ls "lsd"
        alias ll "lsd -l"
        alias la "lsd -a"
        alias lal "lsd -al"
        alias ".." "cd .."
        alias neofetch "neofetch --ascii ~/.config/ascii-neofetch"
      '';

      functions = {
        # `haskellEnv` from the docs:
        haskellEnv = ''
          function haskellEnv
            # In fish, $argv is the list of arguments.
            # This uses the pkgs.haskellPackages.ghcWithPackages expression:
            nix-shell -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ $argv ])"
          end
        '';

        # `pythonEnv` from the docs:
        pythonEnv = ''
          function pythonEnv --description 'start a nix-shell with the given python packages' --argument pythonVersion
            # If more than one argument is given, shift the second onward into $argv
            # for the actual packages.
            if set -q argv[2]
              set argv $argv[2..-1]
            end

            # Build the list of python packages, e.g. python3Packages.numpy python3Packages.requests
            for el in $argv
              set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
            end

            # Launch nix-shell with those python packages
            nix-shell -p $ppkgs
          end
        '';

        # fish uses “; and” or “; or” instead of Bash’s && and ||
        # Also note the parentheses for command substitution.
        # Everything else remains basically the same.
        folder2txt = ''
          function folder2txt
            set folder_name (basename $argv)
            find $argv -type f -not -path '*/\.*' -print0 | sort -z | xargs -0 awk \
              'BEGINFILE {printf "\n```"; print FILENAME; printf "```\n"} {print} ENDFILE {printf "\n```\n"}' \
              > "$folder_name.txt"
          end
        '';

        rebuild-nixos = ''
          function rebuild-nixos
            # In fish, “set -e” is not a direct equivalent. Instead, fish
            # will keep going on errors unless you use `if ...; and ...; end` or “|| exit”.
            # So you can adapt carefully or allow partial failures.
            echo "Editing flake.nix..."
            $EDITOR flake.nix

            pushd ~/flake2/ > /dev/null

            # Check for changes:
            git diff --quiet flake.nix
            if test $status -eq 0
              echo "No changes detected, exiting."
              popd > /dev/null
              return
            end

            echo "Running alejandra for formatting..."
            alejandra . ^/dev/null
            if test $status -ne 0
              echo "Formatting failed!"
              popd > /dev/null
              return
            end

            # Show changes
            git diff -U0 flake.nix

            echo "NixOS Rebuilding..."
            sudo nixos-rebuild switch --flake .#nora &> nixos-switch.log
            if test $status -ne 0
              cat nixos-switch.log | grep --color error
              popd > /dev/null
              return
            end

            set currentGen (nixos-rebuild list-generations | grep current)
            git commit -am "$currentGen"

            popd > /dev/null
            # fish doesn't have `notify-send -e`, but you can do:
            notify-send "NixOS Rebuilt OK!" --icon=software-update-available
          end
        '';
      };
    };
  }
