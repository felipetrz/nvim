vim.lsp.enable('clangd')
vim.lsp.enable('gleam')
vim.lsp.enable('luals')
vim.lsp.enable('pyright')
vim.lsp.enable('ruff')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('zls')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/formatting') then
            local function format()
                vim.lsp.buf.format({ async = false })
                vim.lsp.buf.code_action({
                    context = { only = { 'source.organizeImports' } },
                    apply = true,
                })
            end
            vim.keymap.set({ 'n', 'x' }, '<c-f>', format, { silent = true })
        end
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
        end
        if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
        end
        if client:supports_method('textDocument/declaration') then
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { silent = true })
        end
        if client:supports_method('textDocument/typeDefinition') then
            vim.keymap.set('n', 'gY', vim.lsp.buf.type_definition, { silent = true })
        end
        if client:supports_method('textDocument/implementation') then
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { silent = true })
        end
        if client:supports_method('textDocument/references') then
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true })
        end
        if client:supports_method('textDocument/rename') then
            vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { silent = true })
        end
        if client:supports_method('textDocument/codeAction') then
            vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { silent = true })
        end
    end,
})

vim.diagnostic.config({
    severity_sort = true,
    virtual_text = true,
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '!!',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        }
    }
})
