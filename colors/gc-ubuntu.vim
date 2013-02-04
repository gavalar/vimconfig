set bg=dark
hi clear
if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "gc-ubuntu"

hi SpecialKey     term=bold cterm=bold ctermfg=4 guifg=4
hi NonText        term=bold cterm=bold ctermfg=4 guifg=4
hi Directory      term=bold cterm=bold ctermfg=6 guifg=6
hi ErrorMsg       term=standout cterm=bold ctermfg=7 ctermbg=1 guifg=7 guibg=1
hi IncSearch      term=reverse cterm=reverse
hi Search         term=reverse ctermfg=0 ctermbg=3 guifg=0 guibg=3
hi MoreMsg        term=bold cterm=bold ctermfg=2 guifg=2
hi ModeMsg        term=bold cterm=bold
hi LineNr         term=underline cterm=bold ctermfg=3 guifg=3
hi Question       term=standout cterm=bold ctermfg=2 guifg=2
hi StatusLine     term=bold,reverse cterm=bold,reverse
hi StatusLineNC   term=reverse cterm=reverse
hi VertSplit      term=reverse cterm=reverse
hi Title          term=bold cterm=bold ctermfg=5 guifg=5
hi Visual         term=reverse cterm=reverse
hi WarningMsg     term=standout cterm=bold ctermfg=1 guifg=1
hi WildMenu       term=standout ctermfg=0 ctermbg=3 guifg=0 guibg=3
hi Folded         term=standout cterm=bold ctermfg=6 ctermbg=0 guifg=6 guibg=0
hi FoldColumn     term=standout cterm=bold ctermfg=6 ctermbg=0 guifg=6 guibg=0
hi DiffAdd        term=bold ctermbg=4 guibg=4
hi DiffChange     term=bold ctermbg=5 guibg=5
hi DiffDelete     term=bold cterm=bold ctermfg=4 ctermbg=6 guifg=4 guibg=6
hi DiffText       term=reverse cterm=bold ctermbg=1 guibg=1
hi SignColumn     term=standout cterm=bold ctermfg=6 ctermbg=0 guifg=6 guibg=0
hi SpellBad       term=reverse ctermbg=1 guibg=1
hi SpellCap       term=reverse ctermbg=4 guibg=4
hi SpellRare      term=reverse ctermbg=5 guibg=5
hi SpellLocal     term=underline ctermbg=6 guibg=6
hi Pmenu          ctermbg=5 guibg=5
hi PmenuSel       ctermbg=0 guibg=0
hi PmenuSbar      ctermbg=7 guibg=7
hi PmenuThumb     cterm=reverse
hi TabLine        term=underline cterm=bold,underline ctermfg=7 ctermbg=0 guifg=7 guibg=0
hi TabLineSel     term=bold cterm=bold
hi TabLineFill    term=reverse cterm=reverse
hi CursorColumn   term=reverse ctermbg=0 guibg=0
hi CursorLine     term=underline cterm=underline
hi MatchParen     term=reverse ctermbg=6 guibg=6
hi Comment        term=bold cterm=bold ctermfg=6 guifg=6
hi Constant       term=underline cterm=bold ctermfg=5 guifg=5
hi Special        term=bold cterm=bold ctermfg=1 guifg=1
hi Identifier     term=underline cterm=bold ctermfg=6 guifg=6
hi Statement      term=bold cterm=bold ctermfg=3 guifg=3
hi PreProc        term=underline cterm=bold ctermfg=4 guifg=4
hi Type           term=underline cterm=bold ctermfg=2 guifg=2
hi Underlined     term=underline cterm=bold,underline ctermfg=4 guifg=4
hi Ignore         ctermfg=0 guifg=0
hi Error          term=reverse cterm=bold ctermfg=7 ctermbg=1 guifg=7 guibg=1
hi Todo           term=standout ctermfg=0 ctermbg=3 guifg=0 guibg=3
hi String         term=underline cterm=bold,underline ctermfg=7 ctermbg=0 guifg=7 guibg=0
hi SpellBad       term=reverse ctermbg=1 guibg=1
hi SpellCap       term=reverse ctermbg=4 guibg=4
hi SpellRare      term=reverse ctermbg=5 guibg=5
hi SpellLocal     term=underline ctermbg=6 guibg=6
hi Pmenu          ctermbg=5 guibg=5
hi PmenuSel       ctermbg=0 guibg=0
hi PmenuSbar      ctermbg=7 guibg=7
hi PmenuThumb     cterm=reverse
hi TabLine        term=underline cterm=bold,underline ctermfg=7 ctermbg=0 guifg=7 guibg=0
hi TabLineSel     term=bold cterm=bold
hi TabLineFill    term=reverse cterm=reverse
hi CursorColumn   term=reverse ctermbg=0 guibg=0
hi CursorLine     term=underline cterm=underline
hi MatchParen     term=reverse ctermbg=6 guibg=6
hi Comment        term=bold cterm=bold ctermfg=6 guifg=6
hi Constant       term=underline cterm=bold ctermfg=5 guifg=5
hi Special        term=bold cterm=bold ctermfg=1 guifg=1
hi Identifier     term=underline cterm=bold ctermfg=6 guifg=6
hi Statement      term=bold cterm=bold ctermfg=3 guifg=3
hi PreProc        term=underline cterm=bold ctermfg=4 guifg=4
hi Type           term=underline cterm=bold ctermfg=2 guifg=2
hi Underlined     term=underline cterm=bold,underline ctermfg=4 guifg=4
hi Ignore         ctermfg=0 guifg=0
hi Error          term=reverse cterm=bold ctermfg=7 ctermbg=1 guifg=7 guibg=1
hi Todo           term=standout ctermfg=0 ctermbg=3 guifg=0 guibg=3
hi String         cterm=bold ctermfg=177 ctermbg=0 guifg=177 guibg=0
hi Character      term=underline cterm=bold,underline ctermfg=7 ctermbg=0 guifg=7 guibg=0
hi Number         cterm=bold ctermfg=141 ctermbg=0 guifg=141 guibg=0
hi Boolean        cterm=bold ctermfg=10 ctermbg=0 guifg=10 guibg=0
hi Float          cterm=bold ctermfg=141 ctermbg=0 guifg=141 guibg=0
hi Function       term=underline cterm=bold ctermfg=6 guifg=6
hi Conditional    term=bold cterm=bold ctermfg=3 guifg=3
hi Repeat         term=bold cterm=bold ctermfg=3 guifg=3
hi Label          term=bold cterm=bold ctermfg=3 guifg=3
hi Operator       term=bold cterm=bold ctermfg=3 guifg=3
hi Keyword        term=bold cterm=bold ctermfg=3 guifg=3
hi Exception      term=bold cterm=bold ctermfg=3 guifg=3
hi Include        term=underline cterm=bold ctermfg=4 guifg=4
hi Define         term=underline cterm=bold ctermfg=4 guifg=4
hi Macro          term=underline cterm=bold ctermfg=4 guifg=4
hi PreCondit      term=underline cterm=bold ctermfg=4 guifg=4
hi StorageClass   term=underline cterm=bold ctermfg=2 guifg=2
hi Structure      term=underline cterm=bold ctermfg=2 guifg=2
hi Typedef        term=underline cterm=bold ctermfg=2 guifg=2
hi Tag            term=bold cterm=bold ctermfg=1 guifg=1
hi SpecialChar    term=bold cterm=bold ctermfg=1 guifg=1
hi Delimiter      term=bold cterm=bold ctermfg=1 guifg=1
hi SpecialComment term=bold cterm=bold ctermfg=1 guifg=1
hi Debug          term=bold cterm=bold ctermfg=1 guifg=1
hi WhitespaceEOL  ctermbg=7 guibg=7
hi DbgCurrent     term=reverse cterm=bold ctermfg=7 ctermbg=1 guifg=7 guibg=1
hi DbgBreakPt     term=reverse cterm=bold ctermfg=7 ctermbg=2 guifg=7 guibg=2

