-- LSP configuration
-- Using nvim-lspconfig for server configs (filetypes, root detection)
-- with LspAttach autocmd for on-attach behavior.
local lspconfig = require("lspconfig")
local lsp_format = require("lsp-format")

lsp_format.setup({})

-- Rounded borders
vim.diagnostic.config({ float = { border = "rounded" } })

-- On-attach via autocmd (nvim 0.11+ pattern)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      lsp_format.on_attach(client, args.buf)
    end
  end,
})

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
  config.capabilities = capabilities
  lspconfig[server].setup(config)
end

-- LSP keymaps
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, desc = "Goto Declaration" })
