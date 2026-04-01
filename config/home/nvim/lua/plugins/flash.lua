require("flash").setup({
  labels = "asdfghjklqwertyuiopzxcvbnm",
  search = { mode = "fuzzy" },
  jump = { autojump = true },
  label = {
    uppercase = false,
    rainbow = { enabled = false, shade = 5 },
  },
})

local map = vim.keymap.set
map({ "n", "x", "o" }, "s", "<cmd>lua require('flash').jump()<cr>", { desc = "Flash" })
map({ "n", "x", "o" }, "S", "<cmd>lua require('flash').treesitter()<cr>", { desc = "Flash Treesitter" })
map("o", "r", "<cmd>lua require('flash').remote()<cr>", { desc = "Remote Flash" })
map({ "x", "o" }, "R", "<cmd>lua require('flash').treesitter_search()<cr>", { desc = "Treesitter Search" })
