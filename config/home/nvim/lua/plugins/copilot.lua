-- Copilot core (suggestions via blink.cmp, not inline)
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

-- CopilotChat
require("CopilotChat").setup({})

local map = vim.keymap.set
map("x", "<leader>a", "", { desc = "+copilot" })
map("x", "<leader>ae", "<cmd>CopilotChatExplain<cr>", { desc = "Explain" })
map("x", "<leader>af", "<cmd>CopilotChatFix<cr>", { desc = "Fix" })
map("x", "<leader>ad", "<cmd>CopilotChatDocs<cr>", { desc = "Docs" })
map("x", "<leader>ac", "<cmd>CopilotChatCommit<cr>", { desc = "Commit" })
