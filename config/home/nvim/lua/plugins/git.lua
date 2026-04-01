-- Gitsigns
require("gitsigns").setup({
  trouble = true,
  current_line_blame = true,
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "│" },
  },
})

local map = vim.keymap.set
map({ "n", "v" }, "<leader>gh", "", { silent = true, desc = "+hunks" })
map("n", "<leader>ghb", ":Gitsigns blame_line<CR>", { silent = true, desc = "Blame line" })
map("n", "<leader>ghd", ":Gitsigns diffthis<CR>", { silent = true, desc = "Diff This" })
map("n", "<leader>ghR", ":Gitsigns reset_buffer<CR>", { silent = true, desc = "Reset Buffer" })
map("n", "<leader>ghS", ":Gitsigns stage_buffer<CR>", { silent = true, desc = "Stage Buffer" })

-- Gitlinker
require("gitlinker").setup({
  callbacks = {
    ["github.com"] = require("gitlinker.hosts").get_github_type_url,
    ["gitlab.dnm.radiofrance.fr"] = require("gitlinker.hosts").get_github_type_url,
  },
})

-- Git worktree
require("git-worktree").setup()
require("telescope").load_extension("git_worktree")

-- LazyGit
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit (root dir)" })
