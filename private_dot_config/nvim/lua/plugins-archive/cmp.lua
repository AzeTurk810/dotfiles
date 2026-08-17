return {
  "saghen/blink.cmp",
  enabled = false,
  dependencies = {
    { "rafamadriz/friendly-snippets" },
    { "windwp/nvim-autopairs" },
  },
  version = "1.*",
  config = function()
    require("nvim-autopairs").setup({})
    require("blink.cmp").setup({
      keymap = {
        preset = "none",
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "accept", "fallback" },
        ["<CR>"] = { "hide", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono"
      },
      completion = {
        menu = {
          border = "rounded",
          scrollbar = false
        },
        documentation = { auto_show = false }
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }

    })
  end
}
