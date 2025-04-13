return {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { '.git', 'pyproject.toml' },
    settings = {
        python = {
            analysis = {
                typeCheckingMode = 'basic',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
            linting = {
                enabled = false,
            },
        },
    },
}
