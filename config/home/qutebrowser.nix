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
    package = pkgs.qutebrowser;
    loadAutoconfig = true;
    settings = {
      colors = {
        webpage = {
          preferred_color_scheme = "dark";
          darkmode = {
            enabled = true;
            algorithm = "lightness-cielab";
            threshold = {
              text = 150;
              background = 100;
            };
            contrast = 0.0;
            policy = {
              images = "smart";
              videos = "smart";
            };
          };
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
      content = {
        user_stylesheets = ["~/.config/qutebrowser/user.css"];
        javascript = {
          clipboard = "access";
          can_access_clipboard = true;
        };
      };
    };
    keyBindings = {
      normal = {
        "<Ctrl-v>" = "spawn mpv {url}";
        ",p" = "spawn --userscript qute-pass";
        ",d" = "config-cycle content.user_stylesheets ~/.config/qutebrowser/user.css \"\"";
        # Flip tab selection bindings
        "J" = "tab-prev";
        "K" = "tab-next";
      };
    };
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      np = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
      nw = "https://nixos.wiki/index.php?search={}";
      g = "https://www.google.com/search?hl=en&q={}";
      DEFAULT = "https://duckduckgo.com/?q={}";
    };
    extraConfig = ''
      # Add any additional Python-based configuration here
      c.content.javascript.enabled = True
      c.content.blocking.method = "both"
      c.content.blocking.adblock.lists = ["https://easylist.to/easylist/easylist.txt", "https://easylist.to/easylist/easyprivacy.txt"]

      # Allow websites to access the clipboard when requested
      config.set('content.javascript.clipboard', 'access')

      # Unbind the default J and K bindings
      config.unbind('J', mode='normal')
      config.unbind('K', mode='normal')

      # Bind J to previous tab and K to next tab
      config.bind('J', 'tab-prev', mode='normal')
      config.bind('K', 'tab-next', mode='normal')
    '';
  };

  home.file.".config/qutebrowser/user.css".text = ''
    /* Custom dark mode CSS */
    @media (prefers-color-scheme: dark) {
      body {
        background-color: #${palette.base00} !important;
        color: #${palette.base05} !important;
      }
      a {
        color: #${palette.base0D} !important;
      }
      /* Add more custom CSS rules here */
    }
  '';
}
