" Name:       angel.vim
" Version:    1.0.0
" Maintainer: angel-dx
" License:    The MIT License (MIT)
"
" A soothing coastal color scheme inspired by beach sunsets
"
" Original inspiration from sunbather.vim and paramount.vim
" but completely reworked with new colors and styling

hi clear

if exists('syntax on')
    syntax reset
endif

let g:colors_name='angel'

" New color palette - coastal theme
let s:deep_blue      = { "gui": "#0A2E38", "cterm": "23"  }
let s:sand           = { "gui": "#E3DCC2", "cterm": "187" }
let s:sea_foam       = { "gui": "#B8D8D8", "cterm": "152" }
let s:coral          = { "gui": "#FF6B6B", "cterm": "203" }
let s:sea_green      = { "gui": "#4F9D8F", "cterm": "72"  }
let s:wave_blue      = { "gui": "#5F97C7", "cterm": "74"  }
let s:sunset         = { "gui": "#FF9E64", "cterm": "209" }
let s:driftwood      = { "gui": "#8B786D", "cterm": "95"  }
let s:light_sand     = { "gui": "#F5F0E1", "cterm": "230" }
let s:dark_sand      = { "gui": "#D2C7A5", "cterm": "187" }

let s:background = &background

if &background == "dark"
  let s:bg              = s:deep_blue
  let s:bg_subtle       = { "gui": "#143844", "cterm": "24"  }
  let s:bg_very_subtle  = { "gui": "#1D4553", "cterm": "24"  }
  let s:norm            = s:sea_foam
  let s:norm_subtle     = s:sea_green
  let s:accent          = s:sunset
  let s:accent2         = s:coral
  let s:visual          = s:wave_blue
else
  let s:bg              = s:light_sand
  let s:bg_subtle       = s:dark_sand
  let s:bg_very_subtle  = { "gui": "#E8E1D1", "cterm": "254" }
  let s:norm            = { "gui": "#3A4A4A", "cterm": "239" }
  let s:norm_subtle     = s:driftwood
  let s:accent          = s:wave_blue
  let s:accent2         = s:sea_green
  let s:visual          = s:coral
endif

" Highlighting function
function! s:h(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
    \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

" Base styling
call s:h("Normal",        {"bg": s:bg, "fg": s:norm})

if &background != s:background
   execute "set background=" . s:background
endif

" Syntax groups - completely reworked
call s:h("Comment",       {"fg": s:norm_subtle, "gui": "italic"})
call s:h("Constant",      {"fg": s:accent2})
call s:h("Identifier",    {"fg": s:norm})
call s:h("Statement",     {"fg": s:accent, "gui": "bold"})
call s:h("PreProc",       {"fg": s:accent})
call s:h("Type",          {"fg": s:norm_subtle})
call s:h("Special",       {"fg": s:accent2, "gui": "italic"})
call s:h("Underlined",    {"fg": s:wave_blue, "gui": "underline"})
call s:h("Error",         {"fg": s:light_sand, "bg": s:coral})
call s:h("Todo",          {"fg": s:sunset, "gui": "bold,underline"})

" UI elements - new styling
call s:h("CursorLine",    {"bg": s:bg_very_subtle})
call s:h("CursorLineNr",  {"fg": s:accent, "bg": s:bg_very_subtle})
call s:h("LineNr",        {"fg": s:norm_subtle})
call s:h("Visual",        {"bg": s:visual, "fg": s:bg})
call s:h("PmenuSel",     {"bg": s:accent, "fg": s:bg})
call s:h("StatusLine",    {"bg": s:bg_very_subtle, "fg": s:norm})
call s:h("TabLineSel",    {"fg": s:accent, "gui": "bold"})

" Links - simplified
hi! link Character        Constant
hi! link Number           Constant
hi! link Boolean          Constant
hi! link String           Constant
hi! link Function         Identifier
hi! link Conditional      Statement
hi! link Repeat           Statement
hi! link Keyword          Statement
hi! link Include          PreProc
hi! link Define           PreProc
hi! link SpecialChar      Special
hi! link Tag              Special
hi! link Delimiter        Special
hi! link SpecialComment   Special
hi! link Debug            Special

" Plugin support - updated colors
call s:h("WhichKey",      {"fg": s:accent, "gui": "bold"})
call s:h("SyntasticWarningSign", {"fg": s:sunset})
call s:h("SyntasticErrorSign",   {"fg": s:coral})

" Add any additional customizations below...
