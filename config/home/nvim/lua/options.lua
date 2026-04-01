local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.showtabline = 2
opt.expandtab = true
opt.smartindent = true
opt.shiftwidth = 2
opt.breakindent = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

-- Text wrap
opt.wrap = true

-- Splitting
opt.splitbelow = true
opt.splitright = true

-- Mouse
opt.mouse = "a"

-- Performance
opt.updatetime = 50

-- Completion
opt.completeopt = { "menuone", "noselect", "noinsert" }

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Colors
opt.termguicolors = true

-- Cursor
opt.cursorline = true

-- Folding
opt.foldcolumn = "0"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Scrolloff
opt.scrolloff = 8

-- Which-key timeout
opt.timeoutlen = 10

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Command line
opt.cmdheight = 0
opt.showmode = false

-- Filetype extensions
vim.filetype.add({
  extension = {
    liq = "liquidsoap",
  },
})
