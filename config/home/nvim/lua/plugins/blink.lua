require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-e>"] = { "cancel", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-Space>"] = { "show", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
  },

  completion = {
    ghost_text = { enabled = true },
    list = {
      max_items = 30,
      selection = { preselect = false, auto_insert = false },
    },
    menu = {
      border = "solid",
      draw = {
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = "solid" },
    },
  },

  sources = {
    default = { "lsp", "copilot", "path", "snippets", "buffer", "emoji" },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-cmp-copilot",
        async = true,
      },
      emoji = {
        name = "Emoji",
        module = "blink-emoji",
      },
      buffer = {
        min_keyword_length = 3,
      },
    },
  },

  snippets = { preset = "default" },

  appearance = {
    nerd_font_variant = "mono",
    kind_icons = {
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
      Copilot = "",
    },
  },
})
