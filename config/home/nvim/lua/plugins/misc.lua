-- Autopairs
require("nvim-autopairs").setup({})

-- Illuminate (highlight word under cursor)
require("illuminate").configure({
  under_cursor = false,
  filetypes_denylist = {
    "Outline",
    "TelescopePrompt",
    "alpha",
    "harpoon",
    "reason",
  },
})

-- Undotree
vim.g.undotree_AutoOpenDiff = 1
vim.g.undotree_FocusOnToggle = 1
vim.keymap.set("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", { silent = true, desc = "Undotree" })

-- Which-key
require("which-key").setup({})

-- Trouble
require("trouble").setup({})

-- Hlchunk (indent guides)
local ok, hlchunk = pcall(require, "hlchunk")
if ok then
  hlchunk.setup({})
end
