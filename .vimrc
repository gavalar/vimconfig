set ts=4
set sw=4
set et
set bg=dark
set smartindent
set fileencodings=utf-8
set t_Co=256
colorscheme gc-ubuntu
set noeb
set novb
set path=.,, "stop that annoying display of every config file on the system!
syntax on
filetype indent on
nmap <C-N><C-N> :set invnumber<CR>
nmap <C-P><C-P> :set invpaste<CR>
nmap <C-H><C-H> :set hls!<CR>
nmap <C-T><C-T> :TlistToggle<CR>
nmap <C-S><C-S> :%s/\s\+$//g<CR>
nmap <C-N><C-S> :/\(isValid(\)\@<!$_\(GET\|POST\|REQUEST\|SERVER\|COOKIE\)
nmap <C-A><C-A> :call PhpQAToggle()<CR>

" Sessions stuff
set sessionoptions+=curdir
set sessionoptions+=buffers
set sessionoptions-=options
map <C-S>1 :mksession! ~/.vim/sess/1<CR>
map <C-S>2 :mksession! ~/.vim/sess/2<CR>
map <C-S>3 :mksession! ~/.vim/sess/3<CR>
map <C-S>4 :mksession! ~/.vim/sess/4<CR>
map <C-S>5 :mksession! ~/.vim/sess/5<CR>

"tab mappings
map<C-]><C-]> :tabp<CR>
map<C-\><C-\> :tabn<CR>

nmap ,w :x<CR>
nmap ,q :q!<CR>
nmap :W :w<CR>
set showcmd
set ruler

set wrapscan
set incsearch
nnoremap <Esc>P P'[v' ]=
set undolevels=1000

:imap ;EM gavin.corbett@dowjones.com
:imap ;D die(__FILE__ . ' : ' . __LINE__);
:imap ;GRC /**<CR>* Greenem<CR>*<CR>* @category   Greenem_Frontend<CR>* @package    models<CR>*/
:imap ;PF  $db = Zend_Db_Table_Abstract::getDefaultAdapter();<CR>$profiler = $db->getProfiler();<CR>$profiler->setEnabled(true);
:nmap <C-T><C-T> <ESC>:TlistToggle<CR>

set ignorecase
set scrolloff=10
set updatecount=50

let php_sql_query=1
let php_htmlInStrngs=1
let php_noShortTags=1
let php_folding=1
set foldlevel=1

map $1 :s/^/# /<CR>
map $2 :s/^# //<CR>
set smartindent

" For PHP Documentor to work
inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-D> :call PhpDocSingle()<CR>
vnoremap <C-D> :call PhpDocRange()<CR>

au BufNewFile,BufRead *.phtml set filetype=php
au BufNewFile,BufRead *.html set filetype=php
au BufNewFile,BufRead *.htm set filetype=php
au BufNewFile,BufRead *.lng set filetype=php
au BufNewFile,BufRead *.inc set filetype=php

" set "make" command when editing php files
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l

" set auto-highlighting of matching brackets for php only
autocmd FileType php DoMatchParen
autocmd FileType php hi MatchParen ctermbg=blue guibg=lightblue

" Basics {
    set nocompatible " explicitly get out of vi-compatible mode
    set noexrc " don't use local version of .(g)vimrc, .exrc
    set background=dark " we plan to use a dark background
    set cpoptions=aABceFsmq
    "             |||||||||
    "             ||||||||+-- When joining lines, leave the cursor
    "             |||||||      between joined lines
    "             |||||||+-- When a new match is created (showmatch)
    "             ||||||      pause for .5
    "             ||||||+-- Set buffer options when entering the
    "             |||||      buffer
    "             |||||+-- :write command updates current file name
    "             ||||+-- Automatically add <CR> to the last line
    "             |||      when using :@r
    "             |||+-- Searching continues at the end of the match
    "             ||      at the cursor position
    "             ||+-- A backslash has no special meaning in mappings
    "             |+-- :write updates alternative file name
    "             +-- :read updates alternative file name
    syntax on " syntax highlighting on
" }

" General {
    filetype plugin indent on " load filetype plugins/indent settings
    "set autochdir " always switch to the current file directory
    autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
    set backspace=indent,eol,start " make backspace a more flexible
    set backup " make backup files
    set backupdir=~/.vim/backup " where to put backup files
    set clipboard+=unnamed " share windows clipboard
    set directory=~/.vim/tmp " directory to place swap files in
    set fileformats=unix,dos,mac " support all three, in this order
    set hidden " you can change buffers without saving
    " (XXX: #VIM/tpope warns the line below could break things)
    set iskeyword+=_,$,@,%,# " none of these are word dividers
    "set mouse=a "a = use mouse everywhere n/v/i (normal/visual/insert) modes
    set noerrorbells " don't make noise
    set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
    "             | | | | | | | | |
    "             | | | | | | | | +-- "]" Insert and Replace
    "             | | | | | | | +-- "[" Insert and Replace
    "             | | | | | | +-- "~" Normal
    "             | | | | | +-- <Right> Normal and Visual
    "             | | | | +-- <Left> Normal and Visual
    "             | | | +-- "l" Normal and Visual (not recommended)
    "             | | +-- "h" Normal and Visual (not recommended)
    "             | +-- <Space> Normal and Visual
    "             +-- <BS> Normal and Visual
    set wildmenu " turn on command line completion wild style
    " ignore these list file extensions
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,
                    \*.jpg,*.gif,*.png
    set wildmode=list:longest " turn on wild mode huge list
" }

" Vim UI {
    "set cursorcolumn " highlight the current column
    "set cursorline " highlight current line
    set incsearch " BUT do highlight as you type you
                   " search phrase
    set laststatus=2 " always show the status line
    set lazyredraw " do not redraw while running macros
    set linespace=0 " don't insert any extra pixel lines
                     " betweens rows
    set list " we do what to show tabs, to ensure we get them
              " out of my files
    "set listchars=tab:>-,trail:- " show tabs and trailing
    set matchtime=5 " how many tenths of a second to blink
                     " matching brackets for
    set nohlsearch " do not highlight searched for phrases
    set nostartofline " leave my cursor where it was
    set novisualbell " don't blink
    set number " turn on line numbers
    set numberwidth=5 " We are good up to 99999 lines
    set report=0 " tell us when anything is changed via :...
    set ruler " Always show current positions along the bottom
    set scrolloff=10 " Keep 10 lines (top/bottom) for scope
    set shortmess=aOstT " shortens messages to avoid
                         " 'press a key' prompt
    set showcmd " show the command being typed
    set showmatch " show matching brackets
    set sidescrolloff=10 " Keep 5 lines at the size
    set statusline=%F%m%r%h%w[%L]=[%{&ff}]%y[%p%%][%04l,%04v]
    "              | | | | |  |   |      |  |     |    |
    "              | | | | |  |   |      |  |     |    + current
    "              | | | | |  |   |      |  |     |       column
    "              | | | | |  |   |      |  |     +-- current line
    "              | | | | |  |   |      |  +-- current % into file
    "              | | | | |  |   |      +-- current syntax in
    "              | | | | |  |   |          square brackets
    "              | | | | |  |   +-- current fileformat
    "              | | | | |  +-- number of lines
    "              | | | | +-- preview flag in square brackets
    "              | | | +-- help flag in square brackets
    "              | | +-- readonly flag in square brackets
    "              | +-- rodified flag in square brackets
    "              +-- full path to file in the buffer
" }

" Text Formatting/Layout {
    set completeopt= " don't use a pop up menu for completions
    set expandtab " no real tabs please!
    set formatoptions=rq " Automatically insert comment leader on return,
                          " and let gq format comments
    set ignorecase " case insensitive by default
    set infercase " case inferred by default
"    set nowrap " do not wrap line
    set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
    set smartcase " if there are caps, go case-sensitive
    set shiftwidth=4 " auto-indent amount when using cindent,
                      " >>, << and stuff like that
    set softtabstop=4 " when hitting tab or backspace, how many spaces
                       "should a tab be (see expandtab)
    set tabstop=4 " real tabs should be 8, and they will show with
                   " set list on
" }

" Folding {
    set foldenable " Turn on folding
    set foldmarker={,} " Fold C style code (only use this as default
                        " if you use a high foldlevel)
    set foldmethod=marker " Fold on the marker
"    set foldlevel=100 " Don't autofold anything (but I can still
                      " fold manually)
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements
                                                      " open folds
    function SimpleFoldText() " {
        return getline(v:foldstart).' '
    endfunction " }
    set foldtext=SimpleFoldText() " Custom fold text function
                                   " (cleaner than default)
" }

" Plugin Settings {
    let b:match_ignorecase = 1 " case is stupid
    let perl_extended_vars=1 " highlight advanced perl vars
                              " inside strings

    " TagList Settings {
        let Tlist_Auto_Open=0 " let the tag list open automagically
        let Tlist_Compact_Format = 1 " show small menu
        let Tlist_Ctags_Cmd = 'ctags' " location of ctags
        let Tlist_Enable_Fold_Column = 0 " do show folding tree
        let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill
                                        " yourself
        let Tlist_File_Fold_Auto_Close = 0 " fold closed other trees
        let Tlist_Sort_Type = "name" " order by
        let Tlist_Use_Right_Window = 1 " split to the right side
                                        " of the screen
        let Tlist_WinWidth = 40 " 40 cols wide, so i can (almost always)
                                 " read my functions
        let Tlist_Auto_Open = 1
        let Tlist_Auto_Update = 1
        let Tlist_Auto_Highlight_Tag = 1
        let Tlist_Display_Tag_Scope = 1
        "let Tlist_Display_Prototype = 1
        let Tlist_Show_One_File = 0
        " Language Specifics {
            " just functions and classes please
            let tlist_aspjscript_settings = 'asp;f:function;c:class'
            " just functions and subs please
            let tlist_aspvbs_settings = 'asp;f:function;s:sub'
            " don't show variables in freaking php
            let tlist_php_settings = 'php;c:class;d:constant;f:function'
            " just functions and classes please
            let tlist_vb_settings = 'asp;f:function;c:class'
        " }
    " }
" }

" Mappings {
    " ROT13 - fun
    map <F12> ggVGg?

    " space / shift-space scroll in normal mode
    noremap <S-space> <C-b>
    noremap <space> <C-f>

    " Make Arrow Keys Useful Again {
"        map <down> <ESC>:bn<RETURN>
"        map <left> <ESC>:NERDTreeToggle<RETURN>
"        map <right> <ESC>:Tlist<RETURN>
"        map <up> <ESC>:bp<RETURN>
    " }
" }

" Autocommands {
    " Ruby {
        " ruby standard 2 spaces, always
        au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2
        au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2
    " }
    " Notes {
        " I consider .notes files special, and handle them differently, I
        " should probably put this in another file
        au BufRead,BufNewFile *.notes set foldlevel=2
        au BufRead,BufNewFile *.notes set foldmethod=indent
        au BufRead,BufNewFile *.notes set foldtext=foldtext()
        au BufRead,BufNewFile *.notes set listchars=tab:\ \
        au BufRead,BufNewFile *.notes set noexpandtab
        au BufRead,BufNewFile *.notes set shiftwidth=8
        au BufRead,BufNewFile *.notes set softtabstop=8
        au BufRead,BufNewFile *.notes set tabstop=8
        au BufRead,BufNewFile *.notes set syntax=notes
        au BufRead,BufNewFile *.notes set nocursorcolumn
        au BufRead,BufNewFile *.notes set nocursorline
"        au BufRead,BufNewFile *.notes set guifont=Consolas:h10
        au BufRead,BufNewFile *.notes set spell
    " }
    au BufNewFile,BufRead *.ahk setf ahk
" }

" GUI Settings {
if has("gui_running")
    " Basics {
"        colorscheme darkburn " my color scheme (only works in GUI)
        set columns=180 " perfect size for me
"        set guifont=Consolas:h8 " My favorite font
        set guioptions=ce
        "              ||
        "              |+-- use simple dialogs rather than pop-ups
        "              +  use GUI tabs, not console style tabs
        set lines=65 " perfect size for me
        set mousehide " hide the mouse cursor when typing
    " }

    " Font Switching Binds {
        map <F8> <ESC>:set guifont=Consolas:h8<CR>
        map <F9> <ESC>:set guifont=Consolas:h10<CR>
        map <F10> <ESC>:set guifont=Consolas:h12<CR>
        map <F11> <ESC>:set guifont=Consolas:h16<CR>
        map <F12> <ESC>:set guifont=Consolas:h20<CR>
    " }
endif
" }
set showtabline=2
"set guifont=Terminal 8
set guifont=Andale\ Mono\ 9
set formatoptions=tcqor
set comments=sl:/*,mb:*,elx:*/


" php syntax stuffs
let php_sql_query = 1
let php_htmlInStrings = 1
let php_baselib = 1
let php_smart_members = 1
let php_alt_properties = 1
let php_short_tags = 0

au BufNewFile,BufRead *.inc set ts=2
au BufNewFile,BufRead *.inc set sw=2
autocmd BufWritePre * :%s/\s\+$//e

highlight WhitespaceEOL ctermbg=lightgray guibg=lightgray
match WhitespaceEOL /s+$/
au BufWinEnter *.php let w:m1=matchadd('Search', '\%<161v.\%>77v', -1)
au BufWinEnter *.php let w:m2=matchadd('ErrorMsg', '\%>160v.\+', -1)
au BufWinEnter *.php let w:m3=matchadd('ErrorMsg', '\s\+$', -1)
au BufWinEnter *.php let w:m4=matchadd('ErrorMsg', '\(if\|foreach\|switch\|elseif\)(', -1)
au BufRead,BufNewFile inc.php set syntax=php

au FileType php set omnifunc=phpcomplete#CompletePHP
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

call pathogen#helptags()
execute pathogen#infect()

" change the mapleader from \ to ,
let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.
nmap <silent> ,/ :nohlsearch<CR>
cmap w!! w !sudo tee % >/dev/null
let g:gist_detect_filetype = 1

" markdown
augroup mkd
    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
augroup END

" Ctags open in new window
:nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
" let g:gist_browser_command = 'opera %URL% &'

if has("autocmd")
       " When editing a file, always jump to the last cursor position
       "    autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
endif

let g:phpqa_messdetector_ruleset = "~/.vim/qatools/pmd.xml"
let g:phpqa_codesniffer_args = "--standard=FNO"
let g:phpqa_messdetector_autorun = 0  "Run messdetector on save
let g:phpqa_codesniffer_autorun = 0 "Run codesniffer on save
let g:phpqa_codecoverage_autorun = 0 "Don't show code coverage on load
let g:SuperTabDefaultCompletionType = "context"
let g:command_t_loaded = 0 "Disable Command T as not working just yet
let g:airline_enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

function! PhpQAToggle()
    if g:phpqa_messdetector_autorun
        let g:phpqa_messdetector_autorun = 0
    else
        let g:phpqa_messdetector_autorun = 1
    endif

    if g:phpqa_codesniffer_autorun
        let g:phpqa_codesniffer_autorun = 0
    else
        let g:phpqa_codesniffer_autorun = 1
    endif
endfunction

let g:gitgutter_diff_args = '-w'

" Things for JS (Node.js) conventions 2 spaces (not 4)
au BufNewFile,BufRead *.js set filetype=javascript
au BufNewFile,BufRead jquery.*.js set filetype=javascript syntax=jquery
au BufNewFile,BufRead *.json set filetype=javascript
au BufNewFile,BufRead *.mu set filetype=html
autocmd FileType javascript :setlocal sw=2 ts=2 sts=2
