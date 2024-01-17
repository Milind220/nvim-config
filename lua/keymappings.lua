-- NOTE: This is not ALL the keymapping that I've made. Rlugin specific ones are in plugin modules.
-- spaces not tabs
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- don't wrap my lines ya bastard
vim.cmd("set nowrap")

-- nice big spacebar as our mapleader key
vim.g.mapleader = " "

-- the escape key is waaaaayy too far away
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('v', 'jk', '<Esc>')



