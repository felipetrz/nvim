local job = require('plenary.job')

local ENDPOINT = 'https://models.inference.ai.azure.com/chat/completions'
local TOKEN = os.getenv('GITHUB_TOKEN')

local M = {}

M.prompt = function(params)
    local request_body = {
        model = 'gpt-4.1',
        messages = {},
    }

    if params.system then
        table.insert(request_body.messages, {
            role = 'system',
            content = params.system,
        })
    end

    if params.user then
        table.insert(request_body.messages, {
            role = 'user',
            content = params.user,
        })
    end

    if not request_body.messages then
        -- No messages provided
        return
    end

    vim.schedule(function()
        job:new({
            command = 'curl',
            args = {
                '-s', '-X', 'POST',
                '-H', 'Content-Type: application/json',
                '-H', 'Authorization: Bearer ' .. TOKEN,
                '-d', vim.fn.json_encode(request_body),
                ENDPOINT,
            },
            on_exit = function(j, return_val)
                local result = table.concat(j:result(), '\n')

                if return_val ~= 0 then
                    params.on_error(result)
                    return
                end

                vim.schedule(function()
                    local message = vim.fn.json_decode(result).choices[1].message.content
                    params.callback(message)
                end)
            end,
        }):start()
    end)
end

return M
