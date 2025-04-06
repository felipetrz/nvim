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
    I want you to act as a commit message generator. I will provide you
    with information about the task and the prefix for the task code, and
    I would like you to generate an appropriate commit message using the
    conventional commit format. Do not write any explanations or other
    words, just reply with the commit message.
    Start with a short headline as summary but then list the individual
    changes in more detail.

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
        local message = result.stdout:match('```%s*(.-)%s*```')
        vim.api.nvim_paste(message, false, -1)
    end
end
