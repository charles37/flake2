require("nvim-treesitter.configs").setup({
  -- Grammars are installed via Nix, not dynamically
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})

-- Liquidsoap parser config
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.liquidsoap = {
  filetype = "liquidsoap",
}
