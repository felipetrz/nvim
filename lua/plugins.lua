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
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-telescope/telescope-ui-select.nvim' },
        config = function()
            require('telescope').load_extension('ui-select')
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
