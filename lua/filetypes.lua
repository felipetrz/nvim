vim.filetype.add({
    pattern = {
        ['.*.glsl'] = "glsl",
        ['.*.vert'] = "glsl",
        ['.*.frag'] = "glsl",
        ['.*.wgsl'] = "wgsl",
        ['.*.gleam'] = "gleam",
    },
})
