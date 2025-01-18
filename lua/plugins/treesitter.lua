return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {
                "rust",
                "lua",
                "typescript",
                "tsx",
                "javascript",
                "json",
                "html",
                "css",
                "sql",
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
