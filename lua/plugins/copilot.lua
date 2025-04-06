return {
    {
        'zbirenbaum/copilot.lua',
        opts = {
            suggestion = {
                keymap = {
                    next = '<m-j>',
                    prev = '<m-k>',
                    accept = '<m-l>',
                    dismiss = '<m-h>',
                },
            },
            filetypes = {
                yaml = true,
            },
        },
    },
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        dependencies = {
            'zbirenbaum/copilot.lua',
            { 'nvim-lua/plenary.nvim', branch = 'master' },
        },
        build = 'make tiktoken',
        opts = {},
    },
}
