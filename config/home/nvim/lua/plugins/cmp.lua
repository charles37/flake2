local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Luasnip settings
luasnip.config.setup({
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
})

-- Kind icons
local kind_icons = {
  Text = "󰊄",
  Method = "",
  Function = "󰡱",
  Constructor = "",
  Field = "",
  Variable = "󱀍",
  Class = "",
  Interface = "",
  Module = "󰕳",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

-- Lspkind
lspkind.init({
  symbol_map = { Copilot = "" },
  maxwidth = 50,
  ellipsis_char = "...",
})

cmp.setup({
  experimental = { ghost_text = true },
  performance = {
    debounce = 60,
    fetching_timeout = 200,
    max_view_entries = 30,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = { fields = { "kind", "abbr", "menu" } },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "emoji" },
    { name = "buffer", keyword_length = 3, option = { get_bufnrs = vim.api.nvim_list_bufs } },
    { name = "copilot" },
    { name = "path", keyword_length = 3 },
    { name = "luasnip", keyword_length = 3 },
  }),
  window = {
    completion = { border = "solid" },
    documentation = { border = "solid" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  }),
})

-- Cmdline completions
cmp.setup.cmdline({ "/", "?" }, {
  sources = { { name = "buffer" } },
})

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "cmp_git" },
  }, {
    { name = "buffer" },
  }),
})

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
