hi clear
let g:colors_name = 'felipetrz'

" UI
hi! Search cterm=none ctermfg=lightgray ctermbg=darkgray
hi! CursorLine cterm=none ctermbg=black
hi! CursorLineNr cterm=bold ctermbg=black

" Syntax
hi Statement cterm=none ctermfg=darkgray
hi Comment cterm=none ctermfg=gray
hi Type cterm=none ctermfg=green
hi Delimiter cterm=none ctermfg=gray
hi Identifier cterm=none ctermfg=lightgray
hi Constant cterm=none ctermfg=lightblue
hi @field cterm=none ctermfg=lightcyan
hi @function cterm=bold ctermfg=cyan
hi link @constant.builtin Constant
hi link Include Statement

hi! TreesitterContext cterm=none ctermbg=black
hi! TreesitterContextLineNumber cterm=none ctermbg=black

" Diagnostics

hi clear DiagnosticUnderlineError
hi clear DiagnosticUnderlineWarn
hi clear DiagnosticUnderlineInfo
hi clear DiagnosticUnderlineHint

hi clear Info
hi clear Warn
hi Warn cterm=undercurl gui=undercurl guisp=#f4bf75
hi clear Error
hi Error cterm=undercurl gui=undercurl guisp=#ac4242

hi clear SpellBad
hi link SpellBad Error

hi link DiagnosticUnderlineError Error
hi link DiagnosticUnderlineWarn Warn
hi link DiagnosticUnderlineInfo Info
hi link DiagnosticUnderlineHint Info
