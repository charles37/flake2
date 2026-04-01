vim.g.mapleader = " "

local map = vim.keymap.set

-- Which-key group hints
map("n", "<leader>f", "", { desc = "+find/file" })
map("n", "<leader>s", "", { desc = "+search" })
map("n", "<leader>q", "", { desc = "+quit/session" })
map({ "n", "v" }, "<leader>g", "", { desc = "+git" })
map("n", "<leader>u", "", { desc = "+ui" })
map("n", "<leader>w", "", { desc = "+windows" })
map("n", "<leader><Tab>", "", { desc = "+tab" })
map({ "n", "v" }, "<leader>d", "", { desc = "+debug" })
map({ "n", "v" }, "<leader>c", "", { desc = "+code" })
map({ "n", "v" }, "<leader>t", "", { desc = "+test" })

-- Tabs
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { silent = true, desc = "New Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { silent = true, desc = "Close tab" })

-- Windows
map("n", "<leader>ww", "<C-W>p", { silent = true, desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { silent = true, desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { silent = true, desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { silent = true, desc = "Split window right" })
map("n", "q", "q", { noremap = true, silent = true, desc = "Record macro" })
map("n", "<C-h>", "<C-W>h", { silent = true, desc = "Move to window left" })
map("n", "<C-l>", "<C-W>l", { silent = true, desc = "Move to window right" })
map("n", "<C-k>", "<C-W>k", { silent = true, desc = "Move to window over" })
map("n", "<C-j>", "<C-W>j", { silent = true, desc = "Move to window below" })
map("n", "<C-s>", "<cmd>w<cr><esc>", { silent = true, desc = "Save file" })

-- Quit
map("n", "<leader>qq", "<cmd>quitall<cr><esc>", { silent = true, desc = "Quit all" })

-- Toggle functions
function ToggleLineNumber()
  if vim.wo.number then
    vim.wo.number = false
  else
    vim.wo.number = true
    vim.wo.relativenumber = false
  end
end

function ToggleRelativeLineNumber()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
  else
    vim.wo.relativenumber = true
    vim.wo.number = false
  end
end

function ToggleWrap()
  vim.wo.wrap = not vim.wo.wrap
end

map("n", "<leader>ul", ":lua ToggleLineNumber()<cr>", { silent = true, desc = "Toggle Line Numbers" })
map("n", "<leader>uL", ":lua ToggleRelativeLineNumber()<cr>", { silent = true, desc = "Toggle Relative Line Numbers" })
map("n", "<leader>uw", ":lua ToggleWrap()<cr>", { silent = true, desc = "Toggle Line Wrap" })

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor position on J
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search (centered)" })

-- Paste without overwriting register
map("x", "<leader>p", '"_dP', { desc = "Paste over (keep register)" })

-- System clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Copy to system clipboard" })

-- Delete to void register
map({ "n", "v" }, "<leader>D", '"_d', { desc = "Delete to void register" })

-- Escape from insert
map("i", "<C-c>", "<Esc>")

-- Zen mode
map("n", "<leader>zz", "<CMD> ZenMode | Pencil<CR>", { desc = "Toggle writing mode" })

-- Grapple
map("n", "<leader>m", "<CMD> Grapple toggle <CR>", { desc = "Grapple Toggle tag" })
map("n", "<leader>k", "<CMD> Grapple toggle_tags <CR>", { desc = "Grapple Toggle tags" })
map("n", "<leader>K", "<CMD> Grapple toggle_scopes <CR>", { desc = "Grapple Toggle scopes" })
map("n", "<leader>j", "<CMD> Grapple cycle forward <CR>", { desc = "Grapple Cycle forward" })
map("n", "<leader>J", "<CMD> Grapple cycle backward <CR>", { desc = "Grapple Cycle backward" })
map("n", "<leader>1", "<CMD> Grapple select index=1<CR>", { desc = "Grapple Select 1" })
map("n", "<leader>2", "<CMD> Grapple select index=2<CR>", { desc = "Grapple Select 2" })
map("n", "<leader>3", "<CMD> Grapple select index=3<CR>", { desc = "Grapple Select 3" })
map("n", "<leader>4", "<CMD> Grapple select index=4<CR>", { desc = "Grapple Select 4" })

-- Netrw
map("n", "<leader>pv", ":Ex<CR>")
