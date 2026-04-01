require("conform").setup({
  format_on_save = function(bufnr)
    if vim.g.format_on_save_enabled == nil then
      vim.g.format_on_save_enabled = true
    end
    if vim.g.format_on_save_enabled then
      return {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end
  end,
  notify_on_error = true,
  formatters_by_ft = {
    liquidsoap = { "liquidsoap-prettier" },
    html = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    python = { "black" },
    lua = { "stylua" },
    nix = { "alejandra" },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "yamllint", "yamlfmt" },
  },
})

-- Toggle format on save
local function toggle_format_on_save()
  vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
  if vim.g.format_on_save_enabled then
    vim.notify("Format on save enabled")
    require("lsp-format").enable({})
    local null_ls_client = vim.lsp.get_active_clients({ name = "null-ls" })[1]
    if null_ls_client then
      null_ls_client.server_capabilities.documentFormattingProvider = true
    end
  else
    vim.notify("Format on save disabled")
    require("lsp-format").disable({})
    local null_ls_client = vim.lsp.get_active_clients({ name = "null-ls" })[1]
    if null_ls_client then
      null_ls_client.server_capabilities.documentFormattingProvider = false
    end
  end
end

vim.api.nvim_create_user_command("ToggleFormatOnSave", toggle_format_on_save, {})
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleFormatOnSave<CR>", { silent = true, desc = "Toggle format on save" })
