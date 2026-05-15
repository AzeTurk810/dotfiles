return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      transparent = true,
      theme = "dragon", -- options: wave, dragon, lotus
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Transparency overrides for floating windows
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Save an alias for easier access
          Pmenu = { fg = theme.ui.fg, bg = "none", blend = vim.o.pumblend },
          PmenuSel = { fg = "none", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
    })
    vim.cmd("colorscheme kanagawa-dragon")
  end,
}
