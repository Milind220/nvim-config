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
					"jsonls",
					"lua_ls",
					"clangd",
					"marksman",
					"pyright",
					"biome",
					"ts_ls",
					"denols",
					"tailwindcss",
					"html",
					"cssls",
                    "gopls",
				},
				automatic_installation = true,
				automatic_enable = true,
				handlers = {
					-- default handler for all servers
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
						})
					end,
                    -- override for clangd
                    ["clangd"] = function()
                        require("lspconfig").clangd.setup({
                            capabilities = require("cmp_nvim_lsp").default_capabilities(),
                            root_dir = vim.fn.getcwd(),
                        })
                    end,

					-- override for rust-analyzer
					["rust_analyzer"] = function()
						require("lspconfig").rust_analyzer.setup({
							cmd = { "rustup", "run", "stable", "rust-analyzer" },
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
							settings = {
								["rust-analyzer"] = {
									checkOnSave = {
										command = "clippy",
									},
									diagnostics = {
										enable = true,
										experimental = {
											enable = true,
										},
									},
									procMacro = {
										enable = true,
									},
								},
							},
						})
					end,
					-- explicitly configure denols to avoid conflicts
					["denols"] = function()
						require("lspconfig").denols.setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
							root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
						})
					end,
					-- explicitly configure ts_ls to avoid conflicts
					["ts_ls"] = function()
						require("lspconfig").ts_ls.setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
							root_dir = function(fname)
								-- find the root dir for ts_ls
								local node_root = require("lspconfig").util.root_pattern(
                                    "package.json", 
                                    "tsconfig.json", 
                                    "jsconfig.json"
                                )(fname)
								-- get dir for the current file
								local file_dir = vim.fn.fnamemodify(fname, ":h")

								-- check if deno.json or deno.jsonc
								local has_deno_json = vim.fn.filereadable(file_dir .. "/deno.json") == 1
								local has_deno_jsonc = vim.fn.filereadable(file_dir .. "/deno.jsonc") == 1

								-- if deno.json or deno.jsonc exist, then don't attach ts_ls
								if has_deno_json or has_deno_jsonc then
									return nil
								end

								-- otherwise, return the node_root
								return node_root
							end,
							on_attach = function(client, bufnr)
								-- Fallback: Stop ts_ls if a deno.json is present
								local file_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":h")
								file_dir = require("lspconfig").util.path.join(file_dir, "")
								local has_deno_json = vim.fn.filereadable(file_dir .. "deno.json") == 1
								local has_deno_jsonc = vim.fn.filereadable(file_dir .. "deno.jsonc") == 1
								if has_deno_json or has_deno_jsonc then
									client.stop()
								end
							end,
						})
					end,
                    ["lua_ls"] = function()
                        require("lspconfig").lua_ls.setup({
                            capabilities = require("cmp_nvim_lsp").default_capabilities(),
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                },
                            },
                        })
                    end,
				},
			})
		end,
	},
	{
		-- The Neovim plugin for using LSPs
		"neovim/nvim-lspconfig",
		config = function()
			-- language server related keybindings
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "leader>gf", vim.lsp.buf.format, {}) -- format the file
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}) -- go to definition
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {}) -- go to declaration
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {}) -- go to implementation
			vim.keymap.set("n", "td", vim.lsp.buf.type_definition, {}) -- go to type definition
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {}) -- list all references
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {}) -- rename across all files
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {}) -- code action
		end,
	},
}
