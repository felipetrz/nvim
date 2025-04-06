return {
    'ibhagwan/fzf-lua',
    config = function(_, opts)
        local module = require('fzf-lua')
        module.setup(opts)
        module.register_ui_select()

        vim.keymap.set('n', '<leader>f', '<cmd>FzfLua live_grep<cr>', { silent = true })
        vim.keymap.set('n', '<leader>o', '<cmd>FzfLua files<cr>', { silent = true })
    end,
}
