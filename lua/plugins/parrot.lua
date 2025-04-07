return {
    'frankroeder/parrot.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'ibhagwan/fzf-lua',
    },
    event = 'BufEnter',
    opts = {
        user_input_ui = 'native',
        providers = {
            ollama = { endpoint = os.getenv('OLLAMA_HOST') .. '/api/chat' },
            github = { api_key = os.getenv('GITHUB_TOKEN') },
        },
    },
    keys = {
        { '<c-g>i', '<cmd>PrtPrepend<cr>',         mode = { 'n', 'i' }, desc = 'Prepend' },
        { '<c-g>a', '<cmd>PrtAppend<cr>',          mode = { 'n', 'i' }, desc = 'Append' },
        { '<c-g>c', '<cmd>PrtRewrite<cr>',         mode = { 'n', 'i' }, desc = 'Rewrite' },
        { '<c-g>r', '<cmd>PrtRetry<cr>',           mode = { 'n' },      desc = 'Retry' },
        { '<c-g>s', '<cmd>PrtChatStop<cr>',        mode = { 'n' },      desc = 'Stop' },
        { '<c-g>p', '<cmd>PrtProvider<cr>',        mode = { 'n' },      desc = 'Select Provider' },
        { '<c-g>m', '<cmd>PrtModel<cr>',           mode = { 'n' },      desc = 'Select Model' },
        { '<c-g>q', '<cmd>PrtAsk<cr>',             mode = { 'n' },      desc = 'Ask' },

        { '<c-g>i', ":<c-u>'<,'>PrtPrepend<cr>",   mode = { 'v' },      desc = 'Visual Prepend' },
        { '<c-g>a', ":<c-u>'<,'>PrtAppend<cr>",    mode = { 'v' },      desc = 'Visual Append' },
        { '<c-g>c', ":<c-u>'<,'>PrtRewrite<cr>",   mode = { 'v' },      desc = 'Visual Rewrite' },
        { '<c-g>l', ":<c-u>'<,'>PrtImplement<cr>", mode = { 'v' },      desc = 'Implement Visual' },
    },
}
