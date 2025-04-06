-- File management
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.visualbell = false
vim.opt.autoread = true

-- Performance
vim.opt.ttimeoutlen = 0
vim.opt.updatetime = 250
vim.opt.synmaxcol = 240
vim.opt.lazyredraw = true
vim.opt.hidden = true

-- UI
vim.opt.clipboard = 'unnamedplus'
vim.opt.signcolumn = 'number'
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.winborder = 'rounded'
vim.opt.shortmess:append { c = true, s = true, I = true }
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.wildmenu = true
vim.opt.wildmode = 'list:longest'
vim.opt.mouse = 'a'
vim.opt.scrolloff = 999
vim.opt.history = 1000

-- Formatting
vim.opt.textwidth = 80
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.formatoptions = { q = true, j = true, p = true, [1] = true }

-- Searching
vim.opt.path = { '.', '**' }
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.showmatch = true
vim.opt.hlsearch = true

-- Folding
vim.opt.foldenable = false
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Colors
vim.opt.termguicolors = false
vim.opt.background = 'dark'
vim.cmd.colorscheme 'felipetrz'

require 'keymap'
require 'lazy_install'
require 'lsp'
