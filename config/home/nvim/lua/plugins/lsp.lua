local lspconfig = require("lspconfig")
local lsp_format = require("lsp-format")

lsp_format.setup({})

-- Rounded borders for hover/signature
local _border = "rounded"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = _border })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = _border })
vim.diagnostic.config({ float = { border = _border } })
require("lspconfig.ui.windows").default_options = { border = _border }

-- On-attach: set keymaps and enable formatting
local on_attach = function(client, bufnr)
  lsp_format.on_attach(client, bufnr)
end

-- Default capabilities (with cmp-nvim-lsp)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Server configurations
local servers = {
  clangd = {
    cmd = { "clangd", "--offset-encoding=utf-16" },
  },
  eslint = {},
  html = {},
  lua_ls = {},
  nil_ls = {},
  marksman = {},
  pyright = {},
  gopls = {},
  terraformls = {},
  ts_ls = {},
  yamlls = {},
  hls = {},
  zls = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        genericParameterHints = {
          const = { enable = true },
          lifetime = { enable = true },
          type = { enable = true },
        },
      },
    },
  },
}

for server, config in pairs(servers) do
  config.on_attach = on_attach
  config.capabilities = capabilities
  lspconfig[server].setup(config)
end

-- LSP keymaps (these are overridden by lspsaga where applicable)
local map = vim.keymap.set
map("n", "gD", vim.lsp.buf.declaration, { silent = true, desc = "Goto Declaration" })
