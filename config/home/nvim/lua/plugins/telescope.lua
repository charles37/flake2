require("telescope").setup({
  defaults = {
    layout_config = {
      horizontal = { prompt_position = "top" },
    },
    sorting_strategy = "ascending",
  },
  pickers = {
    colorscheme = { enable_preview = true },
  },
  extensions = {
    file_browser = {},
    fzf = {},
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("lazygit")

local builtin = require("telescope.builtin")
local map = vim.keymap.set

-- Find
map("n", "<leader><space>", builtin.find_files, { desc = "Find project files" })
map("n", "<leader>ps", builtin.live_grep, { desc = "Grep (root dir)" })
map("n", "<leader>:", builtin.command_history, { desc = "Command History" })
map("n", "<leader>b", builtin.buffers, { desc = "+buffer" })
map("n", "<leader>pf", builtin.find_files, { desc = "Find project files" })
map("n", "<leader>pr", builtin.live_grep, { desc = "Find text" })
map("n", "<leader>fR", builtin.resume, { desc = "Resume" })
map("n", "<leader>fg", builtin.oldfiles, { desc = "Recent" })
map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
map("n", "<C-p>", builtin.git_files, { desc = "Search git files" })

-- Git
map("n", "<leader>gc", builtin.git_commits, { desc = "Commits" })
map("n", "<leader>gs", builtin.git_status, { desc = "Status" })

-- Search
map("n", "<leader>sa", builtin.autocommands, { desc = "Auto Commands" })
map("n", "<leader>sb", builtin.current_buffer_fuzzy_find, { desc = "Buffer" })
map("n", "<leader>sc", builtin.command_history, { desc = "Command History" })
map("n", "<leader>sC", builtin.commands, { desc = "Commands" })
map("n", "<leader>sD", builtin.diagnostics, { desc = "Workspace diagnostics" })
map("n", "<leader>sh", builtin.help_tags, { desc = "Help pages" })
map("n", "<leader>sH", builtin.highlights, { desc = "Search Highlight Groups" })
map("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps" })
map("n", "<leader>sM", builtin.man_pages, { desc = "Man pages" })
map("n", "<leader>sm", builtin.marks, { desc = "Jump to Mark" })
map("n", "<leader>so", builtin.vim_options, { desc = "Options" })
map("n", "<leader>sR", builtin.resume, { desc = "Resume" })
map("n", "<leader>uC", builtin.colorscheme, { desc = "Colorscheme preview" })

-- Diagnostics & file browser
map("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document diagnostics" })
map("n", "<leader>fe", "<cmd>Telescope file_browser<cr>", { desc = "File browser" })
map("n", "<leader>fE", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "File browser" })
