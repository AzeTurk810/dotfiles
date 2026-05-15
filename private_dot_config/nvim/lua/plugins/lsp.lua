return {
	"neovim/nvim-lspconfig",
	name = "lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", name = "mason" },
		{ "nvim-treesitter/nvim-treesitter", name = "treesitter" },
		{ "onsails/lspkind.nvim", name = "complationicons" },
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			highlight = {
				enable = true,
				-- vim.lsp.inlay_hint.enable(true),
                additional_vim_regex_highlighting = false,
				-- additional_vim_regex_highli "--clang-tidy",
				-- "--",
				-- "-DONPC"
				-- ghting = false,
			},
		})
		-- WARNING: YENi elave edildi
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = " ",
				},
			},
		})

		-- bitdi

		require("lspkind").setup({
			mode = "symbol_text",

			-- default symbol map
			-- can be either 'default' (requires nerd-fonts font) or
			-- 'codicons' for codicon preset (requires vscode-codicons font)
			--
			-- default: 'default'
			preset = "codicons",

			-- override preset symbols
			--
			-- default: {}
			symbol_map = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "",
			},
		})

		require("mason").setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		vim.lsp.enable("jdtls")
		vim.lsp.enable("bashls")
		vim.lsp.enable("yamlls")
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("pyright")
		vim.lsp.enable("clangd")

		vim.lsp.config("clangd", {
			cmd = { "clangd" },
		})

		-- vim.diagnostic.config({
		--     virtual_text = false,
		--     signs = true,
		--     underline = true,
		--     severity_sort = true,
		--     update_in_insert = false,
		--     float = {
		--         border = "rounded",
		--     },
		-- })

		-- XXX: Yuxaridaki config vscode default config kimidir...
		vim.diagnostic.config({

			virtual_text = {
				prefix = "",
				format = function(diagnostic)
					local icons = {
						[vim.diagnostic.severity.ERROR] = "  ",
						[vim.diagnostic.severity.WARN] = "  ",
						[vim.diagnostic.severity.INFO] = "  ",
						[vim.diagnostic.severity.HINT] = "  ",
					}
					return icons[diagnostic.severity] .. diagnostic.message
				end,
			},
			float = {
				header = "",
				prefix = "",
				border = "rounded",
				style = "minimal",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = " ",
				},
			},
			severity_sort = true,
			underline = true,
			update_in_insert = false,
		})

		-- local orig_util = vim.lsp.util.open_floating_preview
		-- vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
		-- 	opts = opts or {}
		-- 	opts.border = opts.border or "rounded"
		-- 	return orig_util(contents, syntax, opts, ...)
		-- end

		vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
		vim.keymap.set("n", "<leader>k", vim.lsp.buf.format, { silent = true })

		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { silent = true })
		vim.keymap.set("n", "<leader>g", vim.lsp.buf.definition, { silent = true })
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { silent = true })
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { silent = true })
	end,
}
