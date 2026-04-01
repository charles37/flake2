-- Ben's Neovim Configuration
-- Migrated from nixvim-new to pure Lua + Home Manager

require("options")
require("keymaps")
require("colors")

-- Plugin configs
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.conform")
require("plugins.lint")
require("plugins.fidget")
require("plugins.blink")
require("plugins.copilot")
require("plugins.telescope")
require("plugins.git")
require("plugins.ui")
require("plugins.flash")
require("plugins.oil")
require("plugins.grapple")
require("plugins.surround")
require("plugins.textobjects")
require("plugins.todo-comments")
require("plugins.lazydev")
require("plugins.render-markdown")
require("plugins.misc")
