return {
    {
        "folke/which-key.nvim",
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
        version = '*',
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
        "catppuccin/nvim",
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
            vim.cmd.colorscheme "catppuccin"
        end
    },
}
