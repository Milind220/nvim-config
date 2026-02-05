return {
    {
        "Tsuzat/NeoSolarized.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.termguicolors = true
            require("theme").setup()
        end,
    },
    { "folke/tokyonight.nvim", lazy = false },
    { "catppuccin/nvim", name = "catppuccin", lazy = false },
    { "rebelot/kanagawa.nvim", lazy = false },
    { "rose-pine/neovim", name = "rose-pine", lazy = false },
}
