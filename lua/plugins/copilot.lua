return {
    {
        'zbirenbaum/copilot.lua',
        opts = {
            suggestion = {
                auto_trigger = true,
                keymap = {
                    dismiss = false,
                    accept = false,
                    next = false,
                    prev = false,
                },
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
}
