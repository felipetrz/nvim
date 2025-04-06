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
            UnitTests = function(prt, params)
                local template = [[
                I have the following code from {{filename}}:

                ```{{filetype}}
                {{selection}}
                ```

                Please respond by writing table driven unit tests for the code above.
                ]]
                local model_obj = prt.get_model "command"
                prt.logger.info("Creating unit tests for selection with model: " .. model_obj.name)
                prt.Prompt(params, prt.ui.Target.enew, model_obj, nil, template)
            end,
            Debug = function(prt, params)
                local template = [[
                I want you to act as {{filetype}} expert.
                Review the following code, carefully examine it, and report potential
                bugs and edge cases alongside solutions to resolve them.
                Keep your explanation short and to the point:

                ```{{filetype}}
                {{selection}}
                ```
                ]]
                local model_obj = prt.get_model "command"
                prt.logger.info("Debugging selection with model: " .. model_obj.name)
                prt.Prompt(params, prt.ui.Target.enew, model_obj, nil, template)
            end,
            CommitMsg = function(prt, params)
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
                prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
            end,
            CodeConsultant = function(prt, params)
                local chat_prompt = [[
                Your task is to analyze the provided {{filetype}} code and suggest
                improvements to optimize its performance. Identify areas where the
                code can be made more efficient, faster, or less resource-intensive.
                Provide specific suggestions for optimization, along with explanations
                of how these changes can enhance the code's performance. The optimized
                code should maintain the same functionality as the original code while
                demonstrating improved efficiency.

                Here is the code
                ```{{filetype}}
                {{filecontent}}
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
