return {
    {
        -- Mason installs the LSPs
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        -- mason-lspconfig bridges between mason and nvim-lsp config 
        -- + it has this awesome 'ensure_installed' property that makes sure
        -- that the lsps are definitely installed before proceeding
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "arduino_language_server",
                    "clangd",
                    "marksman",
                    "pyright",
                    "rust_analyzer"
                }
            })
        end
    },
    {
        -- The Neovim plugin for using LSPs
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')

            -- Language servers that I require
            -- customised settings can go here
            lspconfig.lua_ls.setup {}
            lspconfig.arduino_language_server.setup {}
            lspconfig.clangd.setup {}
            lspconfig.marksman.setup {}
            lspconfig.pyright.setup {}
            lspconfig.rust_analyzer.setup {}

            -- language server related keybindings
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
        end
    }
}
