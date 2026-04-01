require("todo-comments").setup({})

vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Todo Comments" })
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next Todo Comment" })
vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous Todo Comment" })
