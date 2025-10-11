vim.lsp.enable('clangd')
vim.lsp.enable('luals')
vim.lsp.enable('pyright')
vim.lsp.enable('ruff')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('slint')
vim.lsp.enable('terraform')
vim.lsp.enable('zls')

-- Clear keys used by LSP
vim.keymap.set({ 'n', 'x' }, '<c-f>', '<nop>')
vim.keymap.set('n', 'gd', '<nop>')
vim.keymap.set('n', 'gD', '<nop>')
vim.keymap.set('n', 'gy', '<nop>')
vim.keymap.set('n', 'gi', '<nop>')
vim.keymap.set('n', 'gr', '<nop>')
vim.keymap.set('n', '<leader>r', '<nop>')
vim.keymap.set('n', '<leader>a', '<nop>')

local function check_capability(capability)
    for _, client in ipairs(vim.lsp.get_clients()) do
        if client:supports_method(capability) then
            return client
        end
    end

    return nil
end

local function lsp_action(capability, action)
    return function()
        if check_capability(capability) then
            action()
        end
    end
end

local function format()
    if check_capability('textDocument/formatting') then
        vim.lsp.buf.format({ async = false })
    end
    if check_capability('textDocument/codeAction') then
        -- vim.lsp.buf.code_action { context = { only = { 'source.fixAll' } }, apply = true }
        vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
    end
end

vim.keymap.set({ 'n', 'x' }, '<c-f>', format, { silent = true })
vim.keymap.set('n', 'gd', lsp_action('textDocument/definition', vim.lsp.buf.definition), { silent = true })
vim.keymap.set('n', 'gD', lsp_action('textDocument/declaration', vim.lsp.buf.declaration), { silent = true })
vim.keymap.set('n', 'gy', lsp_action('textDocument/typeDefinition', vim.lsp.buf.type_definition), { silent = true })
vim.keymap.set('n', 'gi', lsp_action('textDocument/implementation', vim.lsp.buf.implementation), { silent = true })
vim.keymap.set('n', 'gr', lsp_action('textDocument/references', vim.lsp.buf.references), { silent = true })
vim.keymap.set('n', '<leader>r', lsp_action('textDocument/rename', vim.lsp.buf.rename), { silent = true })
vim.keymap.set('n', '<leader>a', lsp_action('textDocument/codeAction', vim.lsp.buf.code_action), { silent = true })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
        end
    end,
})

vim.diagnostic.config({
    severity_sort = true,
    virtual_text = true,
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '!',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        }
    }
})
