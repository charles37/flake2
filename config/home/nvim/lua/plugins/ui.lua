local colors = _G.theme_colors

-- Alpha (dashboard)
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "                                                   ",
  " ██████╗ ███████╗███╗   ██╗██╗   ██╗██╗███╗   ███╗ ",
  " ██╔══██╗██╔════╝████╗  ██║██║   ██║██║████╗ ████║ ",
  " ██████╔╝█████╗  ██╔██╗ ██║██║   ██║██║██╔████╔██║ ",
  " ██╔══██╗██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  " ██████╔╝███████╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  " ╚═════╝ ╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                   ",
  "             git@github.com:charles37              ",
}
dashboard.section.header.opts.hl = "AlphaHeader"

dashboard.section.buttons.val = {
  dashboard.button("f", "🔍 Find File", "<CMD>lua require('telescope.builtin').find_files({hidden = true})<CR>"),
  dashboard.button("Q", "💣 Quit Neovim", "<CMD>qa<CR>"),
}

dashboard.section.footer.val = "https://github.com/charles37/nixvim-new"
dashboard.section.footer.opts.hl = "GruvboxBlue"

alpha.setup(dashboard.config)

-- Bufferline
require("bufferline").setup({
  options = {
    separator_style = "thick",
    mode = "buffers",
    themable = true,
  },
  highlights = {
    fill = { fg = colors.base00, bg = colors.base00 },
    background = { fg = colors.base03, bg = colors.base00 },
    buffer_selected = { fg = colors.base05, bg = colors.base00, bold = true, italic = false },
    buffer_visible = { fg = colors.base03, bg = colors.base00 },
    close_button = { fg = colors.base03, bg = colors.base00 },
    close_button_visible = { fg = colors.base03, bg = colors.base00 },
    close_button_selected = { fg = colors.base08, bg = colors.base00 },
    indicator_selected = { fg = colors.base00, bg = colors.base00 },
    modified = { fg = colors.base03, bg = colors.base00 },
    modified_visible = { fg = colors.base00, bg = colors.base00 },
    modified_selected = { fg = colors.base0B, bg = colors.base00 },
    tab_close = { fg = colors.base00, bg = colors.base00 },
  },
})

local map = vim.keymap.set
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Cycle to next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Cycle to previous buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Cycle to next buffer" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Cycle to previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Delete buffers to the right" })
map("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Delete buffers to the left" })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Delete other buffers" })
map("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Toggle pin" })
map("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })

-- Lualine
require("lualine").setup({
  options = {
    globalstatus = true,
    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
    theme = {
      normal = {
        a = { bg = "#b4befe", fg = "#1c1d21" },
        b = { bg = "nil" },
        c = { bg = "nil" },
        z = { bg = "nil" },
        y = { bg = "nil" },
      },
    },
  },
  sections = {
    lualine_a = {
      { "mode", fmt = string.lower, color = { fg = colors.base04, bg = colors.base00 } },
    },
    lualine_b = {
      { "branch", icon = "", color = { fg = colors.base04, bg = colors.base00 } },
      "diff",
    },
    lualine_c = {
      {
        "diagnostics",
        symbols = { error = " ", warn = " ", info = " ", hint = "󰝶 " },
        color = { fg = colors.base08, bg = colors.base00 },
      },
    },
    lualine_x = {
      { "filetype", icon_only = true },
    },
    lualine_y = {
      {
        "filename",
        symbols = { modified = "", readonly = "", unnamed = "" },
        color = { fg = colors.base04, bg = colors.base00 },
      },
    },
    lualine_z = {
      { "location", color = { fg = colors.base0B, bg = colors.base00 } },
    },
  },
})

-- Noice
require("noice").setup({
  popupmenu = { enabled = true, backend = "nui" },
  notify = { enabled = false },
  messages = { enabled = true },
  lsp = {
    message = { enabled = true },
    progress = { enabled = false, view = "mini" },
  },
  format = {
    filter = {
      pattern = { ":%s*%%s*s:%s*", ":%s*%%s*s!%s*", ":%s*%%s*s/%s*", "%s*s:%s*", ":%s*s!%s*", ":%s*s/%s*" },
      icon = "",
      lang = "regex",
    },
    replace = {
      pattern = {
        ":%s*%%s*s:%w*:%s*",
        ":%s*%%s*s!%w*!%s*",
        ":%s*%%s*s/%w*/%s*",
        "%s*s:%w*:%s*",
        ":%s*s!%w*!%s*",
        ":%s*s/%w*/%s*",
      },
      icon = "󱞪",
      lang = "regex",
    },
  },
})

-- Nvim-notify
local notify = require("notify")
notify.setup({
  top_down = true,
  timeout = 1000,
  render = "default",
  fps = 60,
  background_colour = "#000000",
})

-- Override vim.notify to filter "No information available"
local filtered_message = { "No information available" }
---@diagnostic disable-next-line: duplicate-set-field
vim.notify = function(message, level, opts)
  local merged_opts = vim.tbl_extend("force", {
    on_open = function(win)
      local buf = vim.api.nvim_win_get_buf(win)
      vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
    end,
  }, opts or {})

  for _, msg in ipairs(filtered_message) do
    if message == msg then
      return
    end
  end
  return notify(message, level, merged_opts)
end

map("n", "<leader>un", '<cmd>lua require("notify").dismiss({ silent = true, pending = true })<cr>', { desc = "Dismiss All Notifications" })
