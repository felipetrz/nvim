vim.api.nvim_buf_create_user_command(0, 'Generate', function()
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
        if not line:find('^%s*$') and not line:find('^#') then
            -- Commit message already exists, skip generation
            return
        end
    end

    local job = require('plenary.job')

    job:new({
        command = 'git',
        args = { 'diff', '--no-color', '--no-ext-diff', '--staged' },
        on_exit = function(j, return_val)
            vim.schedule(function()
                if return_val ~= 0 then
                    -- Not a git repository
                    return
                end

                local diff = table.concat(j:result(), '\n')
                if diff == '' then
                    -- No staged changes
                    return
                end

                local prompt = vim.fn.json_encode({
                    model = 'qwen2.5-coder:14b-instruct-q2_K',
                    prompt = [[
                    I want you to act as a commit message generator.

                    Read the changes and provide an appropriate commit message
                    detailing every change.
                    Do not write any explanations or other words, just reply with
                    the commit message in the following template format:

                    ```
                    <a short one-line summary of all the changes>

                    - <each change in a list>
                    ```

                    Here are the changes that should be considered by this message:
                    ]] .. diff,
                })

                job:new({
                    command = 'curl',
                    args = {
                        '-s', '-X', 'POST',
                        '-H', 'Content-Type: application/json',
                        '-d', prompt,
                        'http://localhost:11434/api/generate',
                    },
                    on_exit = function(j, return_val)
                        if return_val ~= 0 then
                            -- Error in the request
                            return
                        end

                        local responses_json = {}
                        for _, line in ipairs(j:result()) do
                            table.insert(responses_json, line)
                        end

                        vim.schedule(function()
                            local message = ''
                            for _, line in ipairs(responses_json) do
                                message = message .. vim.fn.json_decode(line).response
                            end
                            message = message:match('```.-\n(.*)```') or message

                            if message then
                                vim.paste(vim.split(message, '\n'), -1)
                            end
                        end)
                    end,
                }):start()
            end)
        end,
    }):start()
end, {})
