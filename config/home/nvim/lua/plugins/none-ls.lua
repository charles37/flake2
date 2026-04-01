local null_ls = require("null-ls")

null_ls.setup({
  update_in_insert = false,
  sources = {
    -- Code actions
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.statix,

    -- Diagnostics
    null_ls.builtins.diagnostics.statix,
    null_ls.builtins.diagnostics.yamllint,

    -- Formatting
    null_ls.builtins.formatting.alejandra,
    null_ls.builtins.formatting.black.with({
      extra_args = { "--fast" },
    }),
    null_ls.builtins.formatting.prettier.with({
      extra_args = { "--no-semi", "--single-quote" },
    }),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.yamlfmt,
  },
})

vim.keymap.set({ "n", "v" }, "<leader>cf", "<cmd>lua vim.lsp.buf.format()<cr>", { silent = true, desc = "Format" })
