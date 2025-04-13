local job = require('plenary.job')
local llm = require('llm')

local COMMIT_LANGUAGE = os.getenv('COMMIT_LANGUAGE') or 'en-US'

local SYSTEM_PROMPT = [[
I want you to act as a commit message generator.

Read the changes and provide an appropriate commit message
detailing every change.
Answer in ]] .. COMMIT_LANGUAGE .. [[.
Do not write any explanations or other words, just reply with
the commit message in the following template format:

```
<a short one-line summary of all the changes>

- <each change in a list>
```

Here are the changes that should be considered by this message:
]]

local function generate()
    job:new({
        command = 'git',
        args = { 'diff', '--no-color', '--no-ext-diff', '--staged' },
        on_exit = function(j, return_val)
            local diff_result = table.concat(j:result(), '\n')

            if return_val ~= 0 then
                error(diff_result)
                return
            end

            if diff_result == '' then
                error('no staged changes')
                return
            end

            llm.prompt({
                system = SYSTEM_PROMPT,
                user = diff_result,
                callback = function(message)
                    message = message:match('```.-\n(.*)```') or message
                    vim.paste(vim.split(message, '\n'), -1)
                end,
                on_error = function(message)
                    error(message)
                end,
            })
        end,
    }):start()
end

vim.api.nvim_buf_create_user_command(0, 'Generate', generate, {})

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = 'COMMIT_EDITMSG',
    callback = function()
        for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
            if not line:find('^%s*$') and not line:find('^#') then
                -- Commit message already exists, skip generation
                return
            end
        end
        generate()
    end,
})
