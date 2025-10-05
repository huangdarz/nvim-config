-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.number = true
vim.o.relativenumber = true
vim.api.nvim_create_autocmd("InsertEnter", { command = ":set norelativenumber" })
vim.api.nvim_create_autocmd("InsertLeave", { command = ":set relativenumber" })
vim.wo.wrap = false
vim.o.signcolumn = "yes"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.expandtab = true

vim.opt.listchars = { space = '·', tab = '»-', trail = '-' }
vim.o.list = true

vim.opt.path:append "**"
vim.o.wildmenu = true

vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Buffer delete' })
vim.keymap.set('n', '<leader>fn', '<cmd>Lexplore<cr>', { desc = 'Open Netrw' })

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- add your plugins here
        {
            "catppuccin/nvim",
            tag = "v1.11.0",
            name = "catppuccin",
            priority = 1000,
            config = function()
                require("catppuccin").setup({
                    integrations = {
                        cmp = true,
                        gitsigns = true,
                        nvimtree = true,
                        treesitter = true,
                        notify = false,
                        mini = {
                            enabled = true,
                            indentscope_color = "lavender",
                        },
                        mason = true,
                    }
                })

                vim.cmd.colorscheme "catppuccin-mocha"
            end
        },
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
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
                vim.keymap.set('n', '<leader>ci', builtin.lsp_implementations,
                    { desc = 'Telescope LSP implementations' })
            end
        },
        {
            "folke/which-key.nvim",
            tag = "v3.17.0",
            event = "VeryLazy",
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                keys = {
                    scroll_down = "<c-n>",
                    scroll_up = "<c-p>",
                }
            },
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
                },
            },
        },
        {
            'echasnovski/mini.nvim',
            tag = 'v0.16.0',
            config = function()
                require('mini.cursorword').setup()
                require('mini.pairs').setup()
                require('mini.git').setup()
                require('mini.diff').setup({
                    view = {
                        style = 'sign',
                        signs = { add = '+', change = '~', delete = '-' }
                    }
                })
                require('mini.icons').setup()
                require('mini.statusline').setup()
                require('mini.indentscope').setup()
                require('mini.tabline').setup()
                require('mini.bracketed').setup()
                require('mini.notify').setup()
                require('mini.starter').setup()
                require('mini.surround').setup()
            end,
        },
        {
            "mason-org/mason.nvim",
            tag = 'v2.1.0',
            opts = {},
            config = function()
                require("mason").setup()

                vim.lsp.config['luals'] = {
                    cmd = { "lua-language-server" },
                    root_markers = { ".luarc.json" },
                    filetypes = { "lua" },
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            },
                        },
                    },
                }

                vim.lsp.config['rust-analyzer'] = {
                    cmd = { "rust-analyzer" },
                    root_markers = { "Cargo.toml" },
                    filetypes = { "rust" },
                }

                vim.lsp.enable({ 'luals', 'rust-analyzer' })

                vim.api.nvim_create_autocmd('LspAttach', {
                    callback = function(ev)
                        local client = vim.lsp.get_client_by_id(ev.data.client_id)
                        if client:supports_method('textDocument/completion') then
                            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
                        end
                    end,
                })

                vim.cmd("set completeopt+=noselect,menuone")
                vim.o.winborder = 'rounded'
                vim.diagnostic.config({ virtual_lines = true })
            end
        },
        {
            "stevearc/conform.nvim",
            tag = 'v9.1.0',
            opts = {},
            config = function()
                require("conform").setup({
                    format_on_save = {
                        -- These options will be passed to conform.format()
                        timeout_ms = 500,
                        lsp_format = "fallback",
                    },
                    -- formatters_by_ft = {
                    --     lua = { "stylua" },
                    --     -- Conform will run multiple formatters sequentially
                    --     python = { "isort", "black" },
                    --     -- You can customize some of the format options for the filetype (:help conform.format)
                    --     rust = { "rustfmt", lsp_format = "fallback" },
                    --     -- Conform will run the first available formatter
                    --     javascript = { "prettierd", "prettier", stop_after_first = true },
                    -- },
                })
            end,
        },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "catppuccin-mocha" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
