local function has_words_before()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

return {
    'hrsh7th/nvim-cmp',
    event = {
        'InsertEnter',
        'CmdlineEnter',
    },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-git',
    },
    config = function()
        local cmp = require('cmp')
        local copilot_suggestion = require('copilot.suggestion')

        cmp.setup({
            experimental = {
                ghost_text = true,
            },
            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<c-space>'] = cmp.mapping.complete(),
                ['<tab>'] = function(fallback)
                    if copilot_suggestion.is_visible() then
                        copilot_suggestion.accept()
                        return
                    end

                    if cmp.visible() then
                        cmp.confirm({ select = true })
                        return
                    end

                    if vim.snippet.active() then
                        vim.snippet.jump(1)
                        return
                    end

                    if vim.bo.buftype ~= 'prompt' and has_words_before() then
                        cmp.complete()
                        return
                    end

                    fallback()
                end,
                ['<s-tab>'] = function(fallback)
                    if vim.snippet.active() then
                        vim.snippet.jump(-1)
                        return
                    end

                    fallback()
                end,
                ['<c-p>'] = function(fallback)
                    if copilot_suggestion.is_visible() then
                        copilot_suggestion.prev()
                        return
                    end

                    fallback()
                end,
                ['<c-n>'] = function(fallback)
                    if copilot_suggestion.is_visible() then
                        copilot_suggestion.next()
                        return
                    end

                    fallback()
                end,
                ['<c-e>'] = function(fallback)
                    if copilot_suggestion.is_visible() then
                        copilot_suggestion.dismiss()
                        return
                    end

                    fallback()
                end,
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'buffer' },
            },
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'cmp_git' },
            }, {
                { name = 'buffer' },
            })
        })

        cmp.event:on('menu_opened', function()
            vim.b.copilot_suggestion_hidden = true
        end)
        cmp.event:on('menu_closed', function()
            vim.b.copilot_suggestion_hidden = false
        end)
    end,
}
