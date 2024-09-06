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
    username
    ;
in
  lib.mkIf (theShell == "nushell") {
    # Configure Nushell
    programs = {
      nushell = {
        enable = true;
        #configFile.source = /home/${username}/config/nushell/confg.nu;
        extraConfig = ''
          # Nushell Config

          # Set environment variables
          $env.ZANEYOS = true
          $env.FLAKEBACKUP = "${flakeBackup}"
          $env.FLAKEPREV = "${flakePrev}"

          # Custom commands
          def folder2txt [folder: path] {
            let folder_name = ($folder | path basename)
            let output_file = $"($folder_name).txt"

            ls $folder -a
            | where type == file
            | where name !~ "^\\."  # Exclude hidden files
            | get name
            | sort
            | each { |file|
                let content = (open $file | into string)
                $"'''---($file)---'''\n($content)\n'''---\n'''
            }
            | str join
            | save $output_file
          }


          let carapace_completer = {|spans|
          carapace $spans.0 nushell $spans | from json
          }
          $env.config = {
           show_banner: false,
           completions: {
           case_sensitive: false # case-sensitive completions
           quick: true    # set to false to prevent auto-selecting completions
           partial: true    # set to false to prevent partial filling of the prompt
           algorithm: "fuzzy"    # prefix or fuzzy
           external: {
           # set to false to prevent nushell looking into $env.PATH to find more suggestions
               enable: true
           # set to lower can improve completion performance at the cost of omitting some options
               max_results: 100
               completer: $carapace_completer # check 'carapace_completer'
             }
           }
          }
          $env.PATH = ($env.PATH |
            split row (char esep) |
            prepend /home/${username}/.apps |
            append /usr/bin/env
          )

          # Run neofetch on startup
          neofetch --ascii ~/.config/ascii-neofetch
        '';
        shellAliases = {
          sv = "sudo nvim";
          flake-rebuild = "nh os switch --hostname ${hostname}";
          flake-update = "nh os switch --hostname ${hostname} --update";
          # gcCleanup = "nix-collect-garbage --delete-old; sudo nix-collect-garbage -d; sudo /run/current-system/bin/switch-to-configuration boot";
          v = "nvim";
          neofetch = "neofetch --ascii ~/.config/ascii-neofetch";
        };
      };
      carapace.enable = true;
      carapace.enableNushellIntegration = true;
    };
  }
