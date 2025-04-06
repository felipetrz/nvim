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
        init = function()
            vim.g.copilot_proxy = os.getenv('COPILOT_PROXY_URL')
            vim.g.copilot_proxy_strict_ssl = false
        end
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
