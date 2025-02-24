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
                    "rust_analyzer",
                    "biome",
                    "ts_ls",
                    "tailwindcss",
                    "html",
                    "cssls",
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
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Language servers that I require
            -- customised settings can go here
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })
            lspconfig.marksman.setup({
                capabilities = capabilities,
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
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
                    },
                },
            })
            lspconfig.biome.setup({
                capabilities = capabilities,
            })

            lspconfig.tailwindcss.setup({
                capabilities = capabilities,
            })

            lspconfig.html.setup({
                capabilities = capabilities,
            })

            lspconfig.cssls.setup({
                capabilities = capabilities,
            })

            lspconfig.jsonls.setup({
                capabilities = capabilities,
            })

            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                -- Optional: Add specific settings for typescript
                -- init_options = {
                --     preferences = {
                --         disableSuggestions = true,
                --     }
                -- }
            })

            -- language server related keybindings
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "leader>gf", vim.lsp.buf.format, {})       -- format the file
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})          -- go to definition
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})         -- go to declaration
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})      -- go to implementation
            vim.keymap.set("n", "td", vim.lsp.buf.type_definition, {})     -- go to type definition
            vim.keymap.set("n", "gr", vim.lsp.buf.references, {})          -- list all references
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})      -- rename across all files

            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {}) -- code action
        end,
    },
}
