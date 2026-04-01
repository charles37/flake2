-- nvim-treesitter-textobjects (standalone API, no nvim-treesitter.configs)
local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")

require("nvim-treesitter-textobjects").setup({
  select = { lookahead = true },
  move = { set_jumps = true },
})

local map = vim.keymap.set

-- Select text objects
local select_maps = {
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["ac"] = "@class.outer",
  ["ic"] = "@class.inner",
  ["aa"] = "@parameter.outer",
  ["ia"] = "@parameter.inner",
  ["ai"] = "@conditional.outer",
  ["ii"] = "@conditional.inner",
  ["al"] = "@loop.outer",
  ["il"] = "@loop.inner",
}

for keys, query in pairs(select_maps) do
  map({ "x", "o" }, keys, function()
    select.select_textobject(query)
  end, { desc = "Select " .. query })
end

-- Move to next/previous
local move_next_start = {
  ["]f"] = "@function.outer",
  ["]c"] = "@class.outer",
  ["]a"] = "@parameter.outer",
}
local move_next_end = {
  ["]F"] = "@function.outer",
  ["]C"] = "@class.outer",
}
local move_prev_start = {
  ["[f"] = "@function.outer",
  ["[c"] = "@class.outer",
  ["[a"] = "@parameter.outer",
}
local move_prev_end = {
  ["[F"] = "@function.outer",
  ["[C"] = "@class.outer",
}

for keys, query in pairs(move_next_start) do
  map({ "n", "x", "o" }, keys, function()
    move.goto_next_start(query)
  end, { desc = "Next " .. query .. " start" })
end
for keys, query in pairs(move_next_end) do
  map({ "n", "x", "o" }, keys, function()
    move.goto_next_end(query)
  end, { desc = "Next " .. query .. " end" })
end
for keys, query in pairs(move_prev_start) do
  map({ "n", "x", "o" }, keys, function()
    move.goto_previous_start(query)
  end, { desc = "Previous " .. query .. " start" })
end
for keys, query in pairs(move_prev_end) do
  map({ "n", "x", "o" }, keys, function()
    move.goto_previous_end(query)
  end, { desc = "Previous " .. query .. " end" })
end

-- Swap parameters
map("n", "<leader>cs", function()
  swap.swap_next("@parameter.inner")
end, { desc = "Swap with next parameter" })
map("n", "<leader>cS", function()
  swap.swap_previous("@parameter.inner")
end, { desc = "Swap with previous parameter" })
