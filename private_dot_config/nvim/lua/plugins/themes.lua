return {
	"https://github.com/paulfrische/reddish.nvim.git",
	"https://github.com/shaunsingh/nord.nvim",
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				float = {
					transparent = true,
				},
				integrations = {
					noice = true,
				},
			})
			-- vim.cmd("colorscheme catppuccin")
		end,
	},

	{
		-- add dracula
		{ "Mofiqul/dracula.nvim" },
	},

	{
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
			-- vim.cmd("colorscheme kanagawa-dragon")
		end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "storm", -- options: storm, night, moon, day
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			-- vim.cmd([[colorscheme tokyonight-storm]])
		end,
	},

	{
		"malleroid/emerald-synth.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("emerald-synth").setup({})
			-- vim.cmd.colorscheme("emerald-synth")
		end,
	},

	{
		"https://github.com/sainnhe/everforest.git",
	},

	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
	{

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
			-- vim.cmd("colorscheme rose-pine")
		end,
	},
}
