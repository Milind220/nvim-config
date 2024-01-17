return {
    "nvim-treesitter/nvim-treesitter",
    build = ".TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {"lua", "c", "rust", "python", "javascript", "arduino"},
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
