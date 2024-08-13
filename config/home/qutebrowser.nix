{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (config.colorScheme) palette;
in {
  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = true;
    settings = {
      colors = {
        webpage = {
          preferred_color_scheme = "dark";
          bg = "#${palette.base00}";
        };
        completion = {
          fg = "#${palette.base05}";
          match.fg = "#${palette.base0B}";
          even.bg = "#${palette.base01}";
          odd.bg = "#${palette.base00}";
          scrollbar = {
            bg = "#${palette.base01}";
            fg = "#${palette.base05}";
          };
        };
        statusbar = {
          normal = {
            bg = "#${palette.base00}";
            fg = "#${palette.base05}";
          };
          insert = {
            bg = "#${palette.base0D}";
            fg = "#${palette.base00}";
          };
          command = {
            bg = "#${palette.base00}";
            fg = "#${palette.base05}";
          };
        };
        tabs = {
          even = {
            bg = "#${palette.base01}";
            fg = "#${palette.base05}";
          };
          odd = {
            bg = "#${palette.base00}";
            fg = "#${palette.base05}";
          };
          selected = {
            even.bg = "#${palette.base02}";
            odd.bg = "#${palette.base02}";
          };
        };
      };
      fonts = {
        default_family = "JetBrainsMono Nerd Font";
        default_size = "11pt";
      };
      tabs.show = "multiple";
      tabs.position = "top";
      statusbar.show = "always";
      content.user_stylesheets = ["~/.config/qutebrowser/user.css"];
    };
    keyBindings = {
      normal = {
        "<Ctrl-v>" = "spawn mpv {url}";
        ",p" = "spawn --userscript qute-pass";
      };
    };
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://nixos.wiki/index.php?search={}";
      g = "https://www.google.com/search?hl=en&q={}";
      DEFAULT = "https://duckduckgo.com/?q={}";
    };
    extraConfig = ''
      # Add any additional Python-based configuration here
      c.content.javascript.enabled = True
      c.content.blocking.method = "both"
      c.content.blocking.adblock.lists = ["https://easylist.to/easylist/easylist.txt", "https://easylist.to/easylist/easyprivacy.txt"]
    '';
  };

  home.file.".config/qutebrowser/user.css".text = ''
    /* Custom dark mode CSS */
    body {
      background-color: #${palette.base00} !important;
      color: #${palette.base05} !important;
    }
    a {
      color: #${palette.base0D} !important;
    }
    /* Add more custom CSS rules here */
  '';
}
