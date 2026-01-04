return {
    -- INFO: c++ tab = 4 de islemesi ucun duzeldecem 04/01/2026
    "nvimtools/none-ls.nvim",
    config = function()
        local null = require("null-ls")
        null.setup({
            sources = {
                null.builtins.formatting.stylua,
                null.builtins.formatting.clang_format.with({
                    extra_args = {
                        "--style={BasedOnStyle: Google, IndentWidth: 4, TabWidth: 4, UseTab: Never, ColumnLimit: 0}",         -- INFO: c++ ucun 4 tab
                    },
                }),
            },
        })
    end,
}
