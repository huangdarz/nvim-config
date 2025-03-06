-- vim options --
vim.o.number = true
vim.o.relativenumber = true
vim.api.nvim_create_autocmd("InsertEnter", {command = ":set norelativenumber"})
vim.api.nvim_create_autocmd("InsertLeave", {command = ":set relativenumber"})

vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.expandtab = true

vim.opt.listchars = { space = '·', tab = '->', trail = '-' }
vim.o.list = true

-- keymaps --
vim.keymap.set('i', 'jk', '<Esc>')

return {}
