return {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { '.git', 'pyproject.toml' },
    settings = {
        python = {
            analysis = {
                typeCheckingMode = 'off',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
            linting = {
                enabled = false,
            },
        },
    },
}
