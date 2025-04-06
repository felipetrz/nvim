return {
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
            gitcommit = true,
            yaml = true,
        },
    },
    config = function(_, opts)
        vim.g.copilot_proxy = 'http://localhost:11435/v1'
        vim.g.copilot_proxy_strict_ssl = false
        require('copilot').setup(opts)
    end
}
