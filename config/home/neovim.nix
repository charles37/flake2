{pkgs, ...}: let
  biscuit-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "biscuit-nvim";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "Biscuit-Colorscheme";
      repo = "nvim";
      rev = "c375565509e47dce6d693bfc7028b7f26dbf2bf7";
      hash = "sha256-VQbhdbDf8POB6+sR4Ys/k7suF8vQvXnFmeyJk6Zyc/o=";
    };
  };
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Colorscheme
      base16-nvim
      biscuit-nvim

      # Completion (blink.cmp replaces nvim-cmp + all cmp-* sources)
      blink-cmp
      blink-cmp-copilot
      blink-emoji-nvim
      copilot-lua

      # Git
      gitsigns-nvim
      lazygit-nvim
      gitlinker-nvim
      git-worktree-nvim

      # LSP (native vim.lsp.config, no nvim-lspconfig needed)
      trouble-nvim
      conform-nvim
      nvim-lint
      fidget-nvim
      hlchunk-nvim

      # Statusline
      lualine-nvim

      # Treesitter
      (nvim-treesitter.withAllGrammars)
      nvim-treesitter-textobjects

      # UI
      alpha-nvim
      bufferline-nvim
      noice-nvim
      nvim-notify
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-file-browser-nvim

      # Utils
      flash-nvim
      grapple-nvim
      vim-illuminate
      nvim-autopairs
      nvim-surround
      oil-nvim
      undotree
      which-key-nvim
      CopilotChat-nvim
      todo-comments-nvim
      lazydev-nvim
      render-markdown-nvim
      lean-nvim

      # Dependencies
      plenary-nvim
      nvim-web-devicons
      nui-nvim
    ];

    extraPackages = with pkgs; [
      # LSP servers
      clang-tools # clangd
      lua-language-server
      nil # nix LSP
      marksman
      pyright
      gopls
      terraform-ls
      typescript-language-server
      yaml-language-server
      haskell-language-server
      zls
      rust-analyzer
      vscode-langservers-extracted # html, eslint, css, json

      # Formatters & linters
      black
      stylua
      alejandra
      prettierd
      nodePackages.prettier
      yamlfmt
      yamllint
      statix

      # Tools
      ripgrep
      lazygit
      cargo
      rustc
    ];

    initLua = let
      nvimDir = ./nvim;
    in ''
      -- Add our config to the runtime path so require() finds lua/ modules
      vim.opt.rtp:prepend("${nvimDir}")
      dofile("${nvimDir}/init.lua")
    '';
  };
}
