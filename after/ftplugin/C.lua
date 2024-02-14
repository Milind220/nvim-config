-- file type override to give C tabstops of 2 spaces
vim.bo.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for i=1,10 do
vim.bo.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.bo.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
vim.bo.expandtab = true -- Use the appropriate number of spaces to insert a <Tab>
