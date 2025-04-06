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

require('lazy').setup({
    spec = {
        { import = 'plugins' },

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
    },
    checker = { enabled = true },
})
