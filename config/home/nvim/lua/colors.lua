-- Everblush base16 color palette
local colors = {
  base00 = "#101618",
  base01 = "#232a2d",
  base02 = "#2d3437",
  base03 = "#404749",
  base04 = "#4f5658",
  base05 = "#cacaca",
  base06 = "#d2d2d2",
  base07 = "#dadada",
  base08 = "#e57474",
  base09 = "#e19d5c",
  base0A = "#e5c76b",
  base0B = "#8ccf7e",
  base0C = "#71baf2",
  base0D = "#67cbe7",
  base0E = "#c47fd5",
  base0F = "#ef7d7d",
}

-- Make colors available globally
_G.theme_colors = colors
_G.theme = "everblush"

-- Setup base16 colorscheme
require("base16-colorscheme").setup(colors)

-- Custom highlights
local hl = vim.api.nvim_set_hl

hl(0, "CursorLine", { fg = "none", bg = "none" })
hl(0, "CursorLineNr", { fg = "none", bg = "none" })
hl(0, "AlphaHeader", { fg = colors.base0E, bg = "none" })
hl(0, "StatusNormal", { bg = "none", fg = "none" })

-- Telescope
hl(0, "TelescopePromptBorder", { fg = colors.base01, bg = colors.base01 })
hl(0, "TelescopePromptNormal", { fg = "none", bg = colors.base01 })
hl(0, "TelescopePromptPrefix", { fg = colors.base08, bg = colors.base01 })
hl(0, "TelescopeSelection", { fg = "none", bg = colors.base01 })

-- Popup menu
hl(0, "Pmenu", { fg = "none", bg = colors.base01 })
hl(0, "PmenuSbar", { fg = "none", bg = colors.base01 })
hl(0, "PmenuThumb", { fg = "none", bg = colors.base01 })
hl(0, "PmenuSel", { fg = "none", bg = colors.base02 })

-- CMP
hl(0, "CmpItemAbbrMatch", { fg = colors.base05, bg = "none" })
hl(0, "CmpItemAbbrMatchFuzzy", { fg = colors.base05, bg = "none" })
hl(0, "CmpItemAbbr", { fg = colors.base03, bg = "none" })
hl(0, "CmpItemKind", { fg = colors.base0E, bg = "none" })
hl(0, "CmpItemMenu", { fg = colors.base0E, bg = "none" })
hl(0, "CmpItemKindSnippet", { fg = colors.base0E, bg = "none" })

-- Borders & floats
hl(0, "VertSplit", { fg = colors.base01, bg = "none" })
hl(0, "FloatBorder", { fg = colors.base01, bg = colors.base01 })
hl(0, "NormalFloat", { fg = "none", bg = colors.base01 })

-- Line numbers
hl(0, "LineNr", { fg = colors.base03, bg = "none" })

-- Noice
hl(0, "NoiceCmdlinePopup", { fg = colors.base04, bg = colors.base01 })
hl(0, "NoiceCmdlinePopupBorder", { fg = colors.base01, bg = colors.base01 })
hl(0, "NoiceCmdlinePopupBorderSearch", { fg = colors.base01, bg = colors.base01 })
