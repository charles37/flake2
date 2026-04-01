-- LSP configuration using native vim.lsp.config (nvim 0.11+)

-- Rounded borders
vim.diagnostic.config({ float = { border = "rounded" } })

-- Default capabilities (with blink.cmp)
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Server configurations using native vim.lsp.config
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

-- LSP keymaps (set on attach so they're buffer-local)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "gr", vim.lsp.buf.references, "Goto References")
    map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
    map("n", "gT", vim.lsp.buf.type_definition, "Type Definition")
    map("n", "K", vim.lsp.buf.hover, "Hover")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
    map("n", "<leader>cw", "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols")
    map("n", "]d", function()
      vim.diagnostic.jump({ count = 1 })
    end, "Next Diagnostic")
    map("n", "[d", function()
      vim.diagnostic.jump({ count = -1 })
    end, "Previous Diagnostic")
  end,
})
