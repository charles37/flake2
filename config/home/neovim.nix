{ config, pkgs, ... }:

let
  plugins = pkgs.vimPlugins;
  theme = config.colorScheme.palette;
in {
  programs.nixvim = {
    enable = true;

    globals.mapleader = " "; # Sets the leader key to space
    
    options = {
      clipboard="unnamedplus";
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
      softtabstop = 2;
      smartindent = true;
      wrap = false;
      swapfile = false;
      backup = false;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 5;         # Adjusted to match second configuration
      updatetime = 50;
      guicursor = "";        # From second configuration
      expandtab = true;      # Ensure tabs are spaces, from second config
      undofile = true;       # Enable undo file, from second config
      signcolumn = "no";     # Adjust sign column, from second config
      colorcolumn = "";      # From second configuration
    };

    colorschemes.base16.enable = true; # Keeping colorscheme from first config
    colorschemes.base16.customColorScheme = { # Custom colorscheme from first config
      base00 = "#${theme.base00}";
      base01 = "#${theme.base01}";
      base02 = "#${theme.base02}";
      base03 = "#${theme.base03}";
      base04 = "#${theme.base04}";
      base05 = "#${theme.base05}";
      base06 = "#${theme.base06}";
      base07 = "#${theme.base07}";
      base08 = "#${theme.base08}";
      base09 = "#${theme.base09}";
      base0A = "#${theme.base0A}";
      base0B = "#${theme.base0B}";
      base0C = "#${theme.base0C}";
      base0D = "#${theme.base0D}";
      base0E = "#${theme.base0E}";
      base0F = "#${theme.base0F}";
    };

    # Merging plugins from both configs, keeping unique ones and combining settings
    plugins = with plugins; {
      barbecue.enable = true;
      gitsigns.enable = true;
      telescope = {
        enable = true;
        keymaps = {
          "<leader>pf" = "find_files"; # From second config
          "<C-p>" = "git_files"; # From second config
          "<leader>ps" = "live_grep"; # From second config
        };
        keymapsSilent = true; # From second config
      };
      indent-blankline.enable = true;
      nvim-colorizer.enable = true;
      nvim-autopairs.enable = true;
      nix.enable = true;
      comment-nvim.enable = true;
      lualine = {
        enable = true;
      };
      startup = { 
        enable = true;
        theme = "dashboard";
      };
      lsp = {
        enable = true;
        keymaps = {
          diagnostic = {
            "<leader>vd" = "open_float";
            "[d" = "goto_next";
            "]d" = "goto_prev";
          };
          lspBuf = {
            gd = "definition";
            K = "hover";
            "<leader>vws" = "workspace_symbol";
            "<leader>vca" = "code_action";
            "<leader>vrr" = "references";
            "<leader>vrn" = "rename";
            "<leader>f"   = "format";
          };
          silent = true;
        };
        servers = {
          tsserver.enable = true;
          lua-ls.enable = true;
          bashls.enable = true;
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
          #nixd.enable = true;
          html.enable = true;
          ccls.enable = true;
          cmake.enable = true;
          csharp-ls.enable = true;
          cssls.enable = true;
          gopls.enable = true;
          jsonls.enable = true;
          pyright.enable = true;
          tailwindcss.enable = true;
          # Additional servers from second config
          eslint = { enable = true; };
          hls = { enable = true; };
          elmls = { enable = true; };
          gleam = { enable = true; };
        };
      };
      harpoon = {
        enable = true;
        enableTelescope = true;
        keymaps = {
          addFile = "<leader> a";
          cmdToggleQuickMenu = "<C-e>";

          navFile = {
            "1" = "<C-h>";
            "2" = "<C-t>";
            "3" = "<C-t>";
            "4" = "<C-t>";
          };
        };
        
      };
      lsp-lines.enable = true;
      luasnip = {
        enable = true;
        #extraConfig = {
        #  enable_autosnippets = true; 
        #  store_selection_keys = "<Tab>";
        #};
      };
      treesitter = {
        enable = true;
        nixGrammars = true; # From first config
        ensureInstalled = "all"; # From second config
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end"; 
          mapping = {
           "<CR>" = "cmp.mapping.confirm({ select = true })"; # From first config
           "<C-d>" = "cmp.mapping.scroll_docs(-4)";
           "<C-e>" = "cmp.mapping.close()";
           "<C-f>" = "cmp.mapping.scroll_docs(4)";
           "<C-j>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";
           "<C-k>" = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })";
           "<C-Space>" = "cmp.mapping.complete()";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
            #{ name = "copilot-vim"; } not necessary
          ];  
        };
      
      #cmdline = {
      #  sources = [
        #    { name = "nvim_lsp"; }
        #    { name = "luasnip"; }
        #    { name = "path"; }
        #    { name = "buffer"; }
        #    #{ name = "copilot-vim"; } not necessary
        #  ];
        #  mapping = {
        #    "<CR>" = "cmp.mapping.confirm({ select = true })"; # From first config
        #    "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        #    "<C-e>" = "cmp.mapping.close()";
        #    "<C-f>" = "cmp.mapping.scroll_docs(4)";
        #    "<C-j>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";
        #    "<C-k>" = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })";
        #    "<C-Space>" = "cmp.mapping.complete()";
        #  };
        #};
      };
      copilot-vim.enable = true; # From second config
    };

    extraPlugins = with pkgs.vimPlugins; [
      # Additional plugins from second configuration
      lean-nvim
      gleam-vim
      nvim-treesitter-parsers.gleam
    ];


    # Merging keymaps from both configurations
    keymaps = [
      #{
      #  key = "<Tab>";
      #  action = ":bnext<CR>";
      #  options.silent = false;
      #}
      #{
      #  key = "<S-Tab>";
      #  action = ":bprev<CR>";
      #  options.silent = false;
      #}
      # Additional keymaps from second configuration
      { mode = "n"; key = "<leader>pv"; action = ":Ex<CR>"; }
      { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; }
      { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; }
      { mode = "n"; key = "J"; action = "mzJ`z"; }
      { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; }
      { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; }
      { mode = "n"; key = "n"; action = "nzzzv"; }
      { mode = "n"; key = "N"; action = "Nzzzv"; }
      { mode = "x"; key = "<leader>p"; action = "\"_dP"; }
      { mode = "n"; key = "<leader>y"; action = "\"+y"; }
      { mode = "v"; key = "<leader>y"; action = "\"+y"; }
      { mode = "n"; key = "<leader>Y"; action = "\"+Y"; }
      { mode = "n"; key = "<leader>d"; action = "\"_d"; }
      { mode = "v"; key = "<leader>d"; action = "\"_d"; }
      { mode = "i"; key = "<C-c>"; action = "<Esc>"; }
      { mode = "n"; key = "Q"; action = "<nop>"; }
      { mode = "n"; key = "<C-f>"; action = "<cmd>silent !tmux neww tmux-sessionizer<CR>"; }
      { mode = "n"; key = "<leader>f"; action = "vim.lsp.buf.format"; }
      { mode = "n"; key = "<C-k>"; action = "<cmd>cnext<CR>zz"; }
      { mode = "n"; key = "<C-j>"; action = "<cmd>cprev<CR>zz"; }
      { mode = "n"; key = "<leader>k"; action = "<cmd>lnext<CR>zz"; }
      { mode = "n"; key = "<leader>j"; action = "<cmd>lprev<CR>zz"; }
      { mode = "n"; key = "<leader>s"; action = ":<C-u>%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left><CR>"; }
      { mode = "n"; key = "<leader>x"; action = "<cmd>!chmod +x %<CR>"; options = { silent = true; }; }
      { mode = "n"; key = "<leader>mr"; action = "<cmd>CellularAutomaton make_it_rain<CR>"; }
      { mode = "n"; key = "<leader><leader>"; action = "function() vim.cmd(\"so\") end"; }
      { mode = "n"; key = "<leader>vpp"; action = "<cmd>e ~/flake/hosts/home.nix<CR>"; }
      { mode = "n"; key = "<leader>cp"; action = ":Copilot enable<CR>"; }
      { mode = "n"; key = "<leader>cn"; action = ":Copilot disable<CR>"; }

    ];

    extraConfigLua = ''
      vim.opt.guifont = "JetBrainsMono\\ NFM,Noto_Color_Emoji:h14"
      vim.g.neovide_cursor_animation_length = 0.05
      vim.g.mapleader = ' '
      vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)
      vim.opt.isfname:append("@-@");

      -- Custom colors defined in the first configuration
      local colors = {
        blue   = '#${theme.base0D}',
        cyan   = '#${theme.base0C}',
        black  = '#${theme.base00}',
        white  = '#${theme.base05}',
        red    = '#${theme.base08}',
        violet = '#${theme.base0E}',
        grey   = '#${theme.base02}',
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.black, bg = colors.black },
        },
        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },
        inactive = {
          a = { fg = colors.white, bg = colors.black },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.black, bg = colors.black },
        },
      }

      require('lualine').setup {
        options = {
          theme = bubbles_theme,
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = { 'filename', 'branch' },
          lualine_c = { 'fileformat' },
          lualine_x = {},
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    '';

    extraConfigVim = ''
      set noshowmode
      inoremap jj <ESC>
    '';
  };
}


