return {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false, -- Load immediately on startup
    priority = 1000, -- Load before other plugins
    config = function()
        require("rose-pine").setup({
            variant = "auto", -- Options: auto, main, moon, or dawn
            dark_variant = "main", -- Options: main, moon, or dawn
            dim_inactive_windows = false,
            extend_background_behind_borders = true,

            enable = {
                terminal = true,
                legacy_highlights = true,
                migrations = true,
            },

            styles = {
                bold = true,
                italic = true,
                transparency = false, -- Set to true for a transparent background
            },

            groups = {
                border = "muted",
                link = "iris",
                panel = "surface",

                error = "love",
                hint = "iris",
                info = "foam",
                note = "pine",
                todo = "rose",
                warn = "gold",

                git_add = "foam",
                git_change = "gold",
                git_delete = "love",
                git_dirty = "rose",
                git_ignore = "muted",
                git_merge = "iris",
                git_rename = "pine",
                git_stage = "iris",
                git_text = "subtle",
            },

            highlight_groups = {
                -- Custom highlight overrides go here
                -- Example: Comment = { fg = "foam", italic = true },
            },
        })

        -- Activate the colorscheme
        vim.cmd("colorscheme rose-pine")
    end
}
