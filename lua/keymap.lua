-- Native

vim.g.mapleader = ' '

vim.keymap.set('n', '<esc>', '<cmd>nohl<cr><esc>', { silent = true })
vim.keymap.set('n', '<bs>', '<c-^>', { silent = true })
vim.keymap.set('n', 'gb', '<c-o>', { silent = true })


-- LSP

vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { silent = true })
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { silent = true })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { silent = true })
vim.keymap.set('n', 'gY', vim.lsp.buf.type_definition, { silent = true })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { silent = true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true })

local function auto_format()
    vim.lsp.buf.format({ async = false })
    vim.lsp.buf.code_action({
        context = { only = { 'source.organizeImports' } },
        apply = true,
    })
end


-- Diagnostics

vim.keymap.set({ 'n', 'x' }, '<c-f>', auto_format, { silent = true })

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
