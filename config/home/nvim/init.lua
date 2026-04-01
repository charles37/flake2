-- Ben's Neovim Configuration
-- Migrated from nixvim-new to pure Lua + Home Manager

require("options")
require("keymaps")
require("colors")

-- Plugin configs
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.lspsaga")
require("plugins.conform")
require("plugins.none-ls")
require("plugins.fidget")
require("plugins.cmp")
require("plugins.copilot")
require("plugins.telescope")
require("plugins.git")
require("plugins.ui")
require("plugins.flash")
require("plugins.oil")
require("plugins.grapple")
require("plugins.misc")
