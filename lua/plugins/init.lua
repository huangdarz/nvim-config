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

return {
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope git files' })
            vim.keymap.set('n', '<leader>fG', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            vim.keymap.set('n', '<leader>ft', builtin.tags, { desc = 'Telescope ctags' })
            vim.keymap.set('n', '<leader>cr', builtin.lsp_references, { desc = 'Telescope LSP references' })
            vim.keymap.set('n', '<leader>cd', builtin.lsp_definitions, { desc = 'Telescope LSP definitions' })
            vim.keymap.set('n', '<leader>ci', builtin.lsp_implementations, { desc = 'Telescope LSP implementations' })
        end
    }
}
