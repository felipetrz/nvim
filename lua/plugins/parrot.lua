return {
    'frankroeder/parrot.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'ibhagwan/fzf-lua',
    },
    event = 'BufEnter',
    opts = {
        user_input_ui = 'native',
        providers = { ollama = {} },
        hooks = {
            Commit = function(prt, params)
                local futils = require "parrot.file_utils"
                if futils.find_git_root() == "" then
                    prt.logger.warning "Not in a git repository"
                    return
                end

                local template = [[
                I want you to act as a commit message generator. I will provide you
                with information about the task and the prefix for the task code, and
                I would like you to generate an appropriate commit message using the
                conventional commit format. Do not write any explanations or other
                words, just reply with the commit message.
                Start with a short headline as summary but then list the individual
                changes in more detail.

                Here are the changes that should be considered by this message:
                ]] .. vim.fn.system "git diff --no-color --no-ext-diff --staged"
                local model_obj = prt.get_model "command"
                prt.Prompt(params, prt.ui.Target.prepend, model_obj, nil, template)
            end,
            Doc = function(prt, params)
                local template = [[
                I want you to act as a {{filetype}} documentation expert. Review the selected
                function carefully, and write a docstring in a manner that's idiomatic for
                {{filetype}}.
                Output just the function with the docstring, in order to replace the original.

                ```{{filetype}}
                {{selection}}
                ```
                ]]
                local model_obj = prt.get_model "command"
                prt.Prompt(params, prt.ui.Target.rewrite, model_obj, nil, template)
            end,
            Debug = function(prt, params)
                local chat_prompt = [[
                I want you to act as {{filetype}} expert.
                Review the following code, carefully examine it, and report potential
                bugs, edge cases, performance and security issues, alongside solutions
                to resolve them.
                Keep your explanation short and to the point:

                ```{{filetype}}
                {{selection}}
                ```
                ]]
                prt.ChatNew(params, chat_prompt)
            end,
        },
    },
    keys = {
        { '<c-g>i', '<cmd>PrtPrepend<cr>',         mode = { 'n', 'i' }, desc = 'Prepend' },
        { '<c-g>a', '<cmd>PrtAppend<cr>',          mode = { 'n', 'i' }, desc = 'Append' },
        { '<c-g>c', '<cmd>PrtRewrite<cr>',         mode = { 'n', 'i' }, desc = 'Rewrite' },
        { '<c-g>r', '<cmd>PrtRetry<cr>',           mode = { 'n' },      desc = 'Retry' },
        { '<c-g>s', '<cmd>PrtChatStop<cr>',        mode = { 'n' },      desc = 'Stop' },
        { '<c-g>p', '<cmd>PrtProvider<cr>',        mode = { 'n' },      desc = 'Select Provider' },
        { '<c-g>m', '<cmd>PrtModel<cr>',           mode = { 'n' },      desc = 'Select Model' },
        { '<c-g>q', '<cmd>PrtAsk<cr>',             mode = { 'n' },      desc = 'Ask' },

        { '<c-g>i', ":<c-u>'<,'>PrtPrepend<cr>",   mode = { 'v' },      desc = 'Visual Prepend' },
        { '<c-g>a', ":<c-u>'<,'>PrtAppend<cr>",    mode = { 'v' },      desc = 'Visual Append' },
        { '<c-g>c', ":<c-u>'<,'>PrtRewrite<cr>",   mode = { 'v' },      desc = 'Visual Rewrite' },
        { '<c-g>l', ":<c-u>'<,'>PrtImplement<cr>", mode = { 'v' },      desc = 'Implement Visual' },
    },
}
