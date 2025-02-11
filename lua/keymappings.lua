-- NOTE: This is not ALL the keymapping that I've made. Rlugin specific ones are in plugin modules.
-- spaces not tabs
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Set indentation for Flutter/Dart files
vim.cmd([[
  autocmd FileType dart setlocal shiftwidth=2 " For block indentation
  autocmd FileType dart setlocal softtabstop=2
  autocmd FileType dart setlocal tabstop=2
  autocmd FileType dart setlocal expandtab
]])

-- Adjust indentation for wrapped lines
vim.cmd([[
  autocmd FileType dart setlocal breakindent
  autocmd FileType dart setlocal breakindentopt=shift:4
]])

-- don't wrap my lines ya bastard
vim.cmd("set nowrap")

-- nice big spacebar as our mapleader key
vim.g.mapleader = " "

-- the escape key is waaaaayy too far away
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("v", "jk", "<Esc>")

-- To copy and paste outside of nvim
vim.keymap.set("n", "<leader>yy", '"+y') -- yank entire line to sys clipboard
vim.keymap.set("n", "<leader>Y", '"+yg_') -- yank to the end of line
vim.keymap.set("v", "<leader>y", '"+y') -- yank selected bit

vim.keymap.set("n", "<leader>p", '"+p') -- paste from sys clipboard after cursor
vim.keymap.set("n", "<leader>P", '"+P') -- paste before cursor
vim.keymap.set("v", "<leader>p", '"+p') -- same, but for visual mode
vim.keymap.set("v", "<leader>P", '"+P')

-- flutter related keymappings
vim.keymap.set("n", "<leader>fr", ":FlutterRun<CR>") -- run the flutter app
vim.keymap.set("n", "<leader>fh", ":FlutterHotReload<CR>") -- hot reload the flutter app
vim.keymap.set("n", "<leader>fq", ":FlutterQuit<CR>") -- quit the flutter app
vim.keymap.set('n', '<leader>fe', ':FlutterEmulators<CR>', { noremap = true, silent = true })

-- Increase/decrease the width of the current vertical split
vim.api.nvim_set_keymap('n', '<leader>=', '<C-w>>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>-', '<C-w><', { noremap = true, silent = true })

-- Increase/decrease the height of the current horizontal split
vim.api.nvim_set_keymap('n', '<leader>+', '<C-w>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>_', '<C-w>-', { noremap = true, silent = true })

-- Change color background scheme
vim.keymap.set("n", "<leader>cc", function()
    if vim.o.background == "dark" then
        vim.cmd("set background=light")
    else
        vim.cmd("set background=dark")
    end
end)

