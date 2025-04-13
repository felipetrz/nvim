return {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { '.git', 'pyproject.toml' },
    init_options = {
        settings = {
            lint = {
                enable = true,
            },
        },
    },
}
