require("oil").setup({
  use_default_keymaps = true,
  delete_to_trash = true,
  float = {
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = { winblend = 0 },
  },
  preview = { border = "rounded" },
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-\\>"] = "actions.select_vsplit",
    ["<C-enter>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-v>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["q"] = "actions.close",
  },
})

vim.keymap.set("n", "-", ":Oil<CR>", { silent = true, desc = "Open parent directory" })
