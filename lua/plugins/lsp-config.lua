return {
	{
		-- Mason installs the LSPs
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		-- mason-lspconfig bridges between mason and nvim-lsp config
		-- + it has this awesome 'ensure_installed' property that makes sure
		-- that the lsps are definitely installed before proceeding
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
                    "json-ls",
					"lua_ls",
					"arduino_language_server",
					"clangd",
					"marksman",
					"pyright",
					"rust_analyzer",
				},
			})
		end,
	},
	{
		-- The Neovim plugin for using LSPs
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
            -- This next line sets up the LSPs so that they have their stuff setup to allow for cmp-nvim-lsp to work
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

			-- Language servers that I require
			-- customised settings can go here
			lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
			lspconfig.arduino_language_server.setup({
				cmd = {
					"arduino-language-server",
					"-cli-config",
					"~/.arduino15/arduino-cli.yaml",
					"-cli",
					"arduino-cli",
					"-clangd",
					"clangd",
					"-fqbn",
					"arduino:avr:uno",
				},
                capabilities = capabilities
			})
			lspconfig.clangd.setup({
                capabilities = capabilities
            })
			lspconfig.marksman.setup({
                capabilities = capabilities
            })
			lspconfig.pyright.setup({
                capabilities = capabilities
            })
			lspconfig.rust_analyzer.setup({
                capabilities = capabilities
            })

			-- language server related keybindings
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
