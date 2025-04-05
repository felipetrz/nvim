return {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { '.git', 'Cargo.toml' },
    settings = {
        cargo = {
            autoreload = true,
        },
        check = {
            features = 'all',
            command = 'clippy',
        },
        rustfmt = {
            extraArgs = { '+nightly' },
        },
        imports = {
            granularity = {
                group = 'item',
            },
        },
    },
}
