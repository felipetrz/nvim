return {
    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = require('treesitter_config.main'),
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = require('treesitter_config.context'),
    },
    'nvim-treesitter/nvim-treesitter-textobjects',

    -- Completion
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = { preset = 'super-tab' },
        },
    },

    -- Finder
    {
        'ibhagwan/fzf-lua',
        config = function()
            local module = require('fzf-lua')
            module.register_ui_select()

            vim.keymap.set('n', '<leader>f', '<cmd>FzfLua live_grep<cr>', { silent = true })
            vim.keymap.set('n', '<leader>o', '<cmd>FzfLua files<cr>', { silent = true })
        end,
    },

    -- QoL
    'Raimondi/delimitMate',
    'alvan/vim-closetag',
    'mg979/vim-visual-multi',
    'michaeljsmith/vim-indent-object',
    'tpope/vim-commentary',
    'tpope/vim-endwise',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-rsi',
    'tpope/vim-surround',

    -- Languages
    'hashivim/vim-terraform',
    'jackguo380/vim-lsp-cxx-highlight',
    'leafgarland/typescript-vim',
    'lepture/vim-jinja',
    'mxw/vim-jsx',
    'othree/html5.vim',
    'pangloss/vim-javascript',
    'peitalin/vim-jsx-typescript',
    'rust-lang/rust.vim',
    'vim-scripts/dbext.vim',
    'ziglang/zig.vim',
}
