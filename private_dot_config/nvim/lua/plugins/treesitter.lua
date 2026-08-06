return {
  'nvim-treesitter/nvim-treesitter',
  run = 'TSUpdate',
  config = function()
    require('nvim-treesitter').setup({
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      }
    })
  end
}
