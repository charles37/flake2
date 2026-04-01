-- Treesitter highlight and indent are enabled by default in recent neovim
-- when grammars are on the rtp (installed via Nix).
-- No require("nvim-treesitter.configs") needed — that module was removed upstream.

vim.treesitter.start = vim.treesitter.start or function() end

-- Ensure highlight and indent are on
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
