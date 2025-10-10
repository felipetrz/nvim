-- Native

vim.g.mapleader = ' '

vim.keymap.set('n', '<esc>', '<cmd>nohl<cr><esc>', { silent = true })
vim.keymap.set('n', '<bs>', '<c-^>', { silent = true })
vim.keymap.set('n', 'gb', '<c-o>', { silent = true })

-- Copy the current file relative path to the clipboard
vim.keymap.set('n', '<c-c>', '<cmd>let @+=expand("%:p:.")<cr>', { silent = true })

-- Insert the current git branch at the cursor location
vim.keymap.set('i', '<c-g>',
    "<c-r>=system('git rev-parse --abbrev-ref HEAD')->trim()<cr>",
    { noremap = true, silent = true }
)

-- Diagnostics

local function diagnostic(direction, severity)
    return function()
        local count = ({ next = 1, prev = -1 })[direction]
        vim.diagnostic.jump({
            count = count,
            float = true,
            severity = { min = severity },
        })
    end
end

vim.keymap.set('n', '<c-h>', diagnostic('prev', 'WARN'), { silent = true })
vim.keymap.set('n', '<c-l>', diagnostic('next', 'WARN'), { silent = true })
vim.keymap.set('n', '<c-k>', diagnostic('prev', 'ERROR'), { silent = true })
vim.keymap.set('n', '<c-j>', diagnostic('next', 'ERROR'), { silent = true })
