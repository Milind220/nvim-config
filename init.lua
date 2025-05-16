local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.cmd("set relativenumber")
vim.cmd("set number")

-- Disable Neovim's built-in Markdown parser
--vim.g.loaded_markdown_parser = 1
--vim.g.loaded_lua_parser = 1

require("keymappings")
require("lazy").setup({
    {
        import = "plugins",
    },
})
