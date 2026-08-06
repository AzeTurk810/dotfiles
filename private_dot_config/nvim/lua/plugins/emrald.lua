return {
  "malleroid/emerald-synth.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("emerald-synth").setup({})
    vim.cmd.colorscheme("emerald-synth")
  end,
}

