-- LSP configuration using native vim.lsp.config (nvim 0.11+)
local lsp_format = require("lsp-format")
lsp_format.setup({})

-- Rounded borders
vim.diagnostic.config({ float = { border = "rounded" } })

-- On-attach via autocmd
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
-- vim.lsp.config uses the server name as key, with filetypes/root_markers
-- nvim-lspconfig still provides the default configs via its plugin/ directory
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

local server_names = {}
for server, config in pairs(servers) do
  config.capabilities = capabilities
  vim.lsp.config(server, config)
  table.insert(server_names, server)
end
vim.lsp.enable(server_names)

-- LSP keymaps
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, desc = "Goto Declaration" })
