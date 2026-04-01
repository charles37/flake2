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
    yaml = { "yamlfmt" },
  },
})

-- Toggle format on save
local function toggle_format_on_save()
  vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
  if vim.g.format_on_save_enabled then
    vim.notify("Format on save enabled")
  else
    vim.notify("Format on save disabled")
  end
end

vim.api.nvim_create_user_command("ToggleFormatOnSave", toggle_format_on_save, {})
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleFormatOnSave<CR>", { silent = true, desc = "Toggle format on save" })
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { silent = true, desc = "Format" })
