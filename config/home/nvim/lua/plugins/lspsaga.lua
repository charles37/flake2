require("lspsaga").setup({
  beacon = { enable = true },
  ui = {
    border = "rounded",
    code_action = "💡",
  },
  hover = {
    open_cmd = "!floorp",
    open_link = "gx",
  },
  diagnostic = {
    border_follow = true,
    diagnostic_only_current = false,
    show_code_action = true,
  },
  symbol_in_winbar = { enable = true },
  code_action = {
    extend_gitsigns = false,
    show_server_name = true,
    only_in_cursor = true,
    num_shortcut = true,
    keys = {
      exec = "<CR>",
      quit = { "<Esc>", "q" },
    },
  },
  lightbulb = {
    enable = false,
    sign = false,
    virtual_text = true,
  },
  implement = { enable = false },
  rename = {
    auto_save = false,
    keys = {
      exec = "<CR>",
      quit = { "<C-k>", "<Esc>" },
      select = "x",
    },
  },
  outline = {
    auto_close = true,
    auto_preview = true,
    close_after_jump = true,
    layout = "normal",
    win_position = "right",
    keys = {
      jump = "e",
      quit = "q",
      toggle_or_jump = "o",
    },
  },
  scroll_preview = {
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
})

local map = vim.keymap.set
map("n", "gd", "<cmd>Lspsaga finder def<CR>", { silent = true, desc = "Goto Definition" })
map("n", "gr", "<cmd>Lspsaga finder ref<CR>", { silent = true, desc = "Goto References" })
map("n", "gI", "<cmd>Lspsaga finder imp<CR>", { silent = true, desc = "Goto Implementation" })
map("n", "gT", "<cmd>Lspsaga peek_type_definition<CR>", { silent = true, desc = "Type Definition" })
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, desc = "Hover" })
map("n", "<leader>cw", "<cmd>Lspsaga outline<CR>", { silent = true, desc = "Outline" })
map("n", "<leader>cr", "<cmd>Lspsaga rename<CR>", { silent = true, desc = "Rename" })
map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true, desc = "Code Action" })
map("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, desc = "Line Diagnostics" })
map("n", "[d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, desc = "Next Diagnostic" })
map("n", "]d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, desc = "Previous Diagnostic" })
