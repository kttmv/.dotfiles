-- vim.api.nvim_exec('language en_US', true)
vim.opt.termguicolors = true
vim.opt.fileformats = 'unix,dos,mac'

-------------------------------------------------------------------------------
-- PLUGINS

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

require("lazy").setup({
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup()
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end,
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeoutlen = 300 -- Set the timeout to 500ms
            require("which-key").setup()
        end,
    },
    {
        "smoka7/hop.nvim",
        as = "hop",
        config = function()
            require("hop").setup()
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({})
        end,
    },
    {
        "neoclide/coc.nvim",
        branch = "release",
    },
    {
        'nvim-telescope/telescope.nvim', 
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup {
                pickers = {
                live_grep = {
                    file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                        additional_args = function(_)
                            return { "--hidden" }
                        end
                    },
                    find_files = {
                        file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                        hidden = true
                    }
                },
            }
        end
    },
    {
        'feline-nvim/feline.nvim',
        config = function() require('feline').setup() end,
    },
    {
        "rmagatti/auto-session",
        config = function()
            require('auto-session').setup({
                auto_session_enable_last_session = true
            })
        end,
    },
    {
        "rmagatti/session-lens",
        dependencies = {"rmagatti/auto-session", "nvim-telescope/telescope.nvim"},
        config = function()
            require('session-lens').setup()
        end,
    },
    {
        'LunarWatcher/auto-pairs'
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('ibl').setup()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
          local configs = require("nvim-treesitter.configs")

          configs.setup({
              ensure_installed = { "lua", "javascript", "typescript", "rust", "html", "c_sharp" },
              sync_install = false,
              highlight = { enable = true },
              indent = { enable = true },  
            })
        end
    },
    {
        'RRethy/vim-illuminate',
    },
})

-------------------------------------------------------------------------------
-- EDITOR

-- Устанавливает количество пробелов, которые соответствуют символу табуляции
vim.o.tabstop = 4
-- Устанавливает количество пробелов при нажатии Tab или Backspace
vim.o.softtabstop = 4
-- Устанавливает количество пробелов для каждого уровня отступа
vim.o.shiftwidth = 4
-- Использует пробелы вместо символов табуляции при нажатии Tab
vim.o.expandtab = true
-- Включает умные авто-отступы при начале новой строки
vim.o.smartindent = true

-- Включает автоматическое обновление заголовка окна
vim.o.title = true

-- Для удобства скролла
vim.o.scrolloff = 16
vim.wo.number = true
vim.wo.relativenumber = true

-- Подсветка на 80 символах
vim.opt.colorcolumn = "80"

-- Отключить мышь
-- vim.o.mouse = ""

-------------------------------------------------------------------------------
-- THEME
vim.cmd("colorscheme kanagawa")



-------------------------------------------------------------------------------
-- MAPPINGS
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.keymap.set("v", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

require("which-key").register({
    c = {
        name = "CoC commands",
        h = {"<cmd>call CocAction('doHover')<cr>", "Show Documentation"},
        f = {"<cmd>call CocActionAsync('format')<cr>", "Format Code"},
        i = {"<Plug>(coc-implementation)", "Go to Implementation"},
        r = {"<Plug>(coc-references)", "Find References"},
        n = {"<Plug>(coc-rename)", "Rename Symbol"},
        d = {"<Plug>(coc-definition)", "Go to Definition"},
        a = {"<Plug>(coc-codeaction-cursor)", "Code actions"},
        v = {"<Plug>(coc-codeaction-selected)", "Code actions on selection"},
    },
    h = {
        name = "Hop",
        w = {"<cmd>HopWord<cr>", "Hop Word"},
        l = {"<cmd>HopLine<cr>", "Hop Line"},
        c = {"<cmd>HopChar1<cr>", "Hop Char"},
    },
    f = {
        name = "Telescope/Session",
        f = {"<cmd>Telescope find_files<cr>", "Find files"},
        g = {"<cmd>Telescope live_grep<cr>", "Live grep"},
        h = {"<cmd>Telescope help_tags<cr>", "Help tags"},
        l = {"<cmd>Telescope lsp_document_symbols<cr>", "LSP symbols"},
        b = {"<cmd>Telescope buffers<cr>", "Buffers"},
        s = {"<cmd>Telescope session-lens search_session<cr>", "Search sessions"},
    },
}, { prefix = "<leader>" })

require("which-key").register({
    c = {
        name = "CoC commands",
        h = {"<cmd>call CocAction('doHover')<cr>", "Show Documentation"},
        f = {"<cmd>call CocActionAsync('format')<cr>", "Format Code"},
        v = {"<Plug>(coc-codeaction-selected)", "Code actions on selection"},
    },
    h = {
        name = "Hop",
        w = {"<cmd>HopWord<cr>", "Hop Word"},
        l = {"<cmd>HopLine<cr>", "Hop Line"},
        c = {"<cmd>HopChar1<cr>", "Hop Char"},
    }
}, { prefix = "<leader>", mode="x" })

-- Accept COC autocomplete action
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? coc#_select_confirm() : "\\<Tab>"', {expr = true, noremap = true})

-- Copy to clipboard
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true })

-- Paste from clipboard
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-v>', '"+p', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-v>', '<Esc>"+pa', { noremap = true })

-- Disable middle mouse click
vim.api.nvim_set_keymap('n', '<MiddleMouse>', '<LeftMouse>', { noremap = true })
vim.api.nvim_set_keymap('v', '<MiddleMouse>', '<LeftMouse>', { noremap = true })
vim.api.nvim_set_keymap('i', '<MiddleMouse>', '<LeftMouse>', { noremap = true })

-- Move in insert mode
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', { noremap = true })
