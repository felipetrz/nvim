return {
    {
        'zbirenbaum/copilot.lua',
        opts = {
            suggestion = {
                enabled = false,
            },
            panel = {
                enabled = false,
            },
            filetypes = {
                gitcommit = true,
                markdown = true,
                yaml = true,
            },
        },
    },
    {
        'zbirenbaum/copilot-cmp',
        config = function()
            require('copilot_cmp').setup()
        end
    },
}
