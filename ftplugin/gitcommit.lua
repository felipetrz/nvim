for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    if not line:find('^%s*$') and not line:find('^#') then
        -- Commit message already exists, skip generation
        return
    end
end

local gitdiff = vim.fn.system('git diff --no-color --no-ext-diff --staged')

if gitdiff then
    local model = 'qwen2.5-coder:14b-instruct-q2_K'

    local prompt = [[
    I want you to act as a commit message generator.

    Read the changes and provide an appropriate commit message detailing every
    change.
    Do not write any explanations or other words, just reply with the commit
    message in the following template format:

    ```
    <a short summary of all the changes>

    - <each change in a list>
    ```

    Here are the changes that should be considered by this message:
    ]] .. gitdiff

    local result = vim.system(
        { 'ollama', 'run', model },
        {
            text = true,
            stdin = prompt,
        }
    ):wait()

    if result.code == 0 then
        local message = result.stdout:match('```.-\n(.-)```')
        vim.api.nvim_paste(message, false, -1)
    end
end
