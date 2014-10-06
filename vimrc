" Eduard Saller {{{
" This is the .vimrc of Eduard Saller
" Feel free to use what you want
" }}}
" Pathogen plugin manager {{{

call pathogen#infect()
call pathogen#helptags()

" }}}
" Statusline using vim-airline plugin {{{

set laststatus=2
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 1

" }}}
" Font settings for GUI version {{{

if has('gui_running')
set guifont=Source\ Code\ Pro\ Semibold\ for\ Powerline:h12
endif

" }}}
" General settings {{{

if has("gui_macvim")
  set fuoptions=maxvert,maxhorz
  au GUIEnter * set fullscreen
endif

filetype plugin indent on
syntax enable                   " Enable syntax highlighting
scriptencoding utf-8            " Encoding for scripts
set history=1000                " Store # amount in history
set spell                       " Spell checking
set hidden                      " Buffer switching without saving
set relativenumber              " Shows the line number relative to the line with the cursor
set background=dark             " Assume dark background
set showmode                    " Show current mode
set cursorline                  " Highlight the screen line of the cursor
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set mouse=a                     " Set mouse mode

" Searching
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

" Scrolling
set scrolljump=1                " Lines to scroll when cursor leaves screen
set scrolloff=5                 " Minimum lines to keep above and below cursor

" Whitespace
set list                        " Enable list mode with listchars
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" Folding
set foldmethod=marker
nnoremap <silent> <leader>z za

" Copy/Paste
if has('clipboard')
  if has('unnamedplus')         " When possible use + register for copy-paste
    set clipboard=unnamedplus
  else                          " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

" }}}
" Solarized theme {{{

if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    color solarized
endif
    let g:solarized_termtrans=1
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"

" }}}
"Coding Standatds {{{

" Column Reminder {{{

highlight colorcolumn guibg=LightYellow ctermbg=LightYellow
call matchadd('colorcolumn', '\%81v', 100)

" }}}
" Indent options {{{

set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent

" }}}

" }}}
" Ruler {{{

if has('cmdline_info')
set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set showcmd
endif

" }}}
" Persistent Undo {{{

set undodir=~/.vim/undodir
set undofile

" }}}
" Gundo Settigns {{{

nnoremap <F5> :GundoToggle<CR>

" }}}
" Fugitive Settings {{{

nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
nnoremap <silent> <leader>gg :GitGutterToggle<CR>

" }}}
" NerdTree Settings {{{

map <C-e> <plug>NERDTreeTabsToggle<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" }}}
" LaTeX Settings {{{

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='open -a Preview'
let g:Tex_CompileRule_pdf='pdflatex'

" }}}
" Autocomplete Configuration {{{

" Jedi Settings {{{

let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0

" }}}
"Neo Complete Settings {{{

let g:acp_enableAtStarup = 0                            "Disble AutoComplPop.
let g:neocomplete#enable_at_startup = 1                 "Use neocomplete.
let g:neocomplete#enable_smart_case = 1                 "Use smartcase.
let g:neocomplete#sources#syntax#min_keyword_length = 3 "Minimum keyword length

" <TAB>: completion

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"}}}
" Omni
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType haxe setlocal omnifunc=vaxe#HaxeComplete


if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python =
            \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#force_omni_input_patterns.c =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.objc =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.objcpp =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
" {{{ eclim Settings
let g:EclimCompletionMethod = 'omnifunc'
let g:neocomplete#force_omni_input_patterns.java = '\k\.\k*'
" }}}
" Enable heavy omni completion. {{{
"if !exists('g:neocomplete#sources#omni#input_patterns')
"    let g:neocomplete#sources#omni#input_patterns = {}
"endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" }}}
" }}}
" Snippet Settings {{{

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" }}}
" Ctags Settings {{{

let Tlist_Ctags_Cmd = "/usr/bin/ctags"
nmap <F8> :TagbarToggle<CR>
nmap <F7> :CtrlPTag<CR>
" }}}
" Rainbow Parentheses Settings{{{

nmap <F6> :RainbowParenthesesToggle<CR> " Toggle Rainbow Parentheses

" }}}
" Tmuxify Settings {{{

let g:tmuxify_custom_command='tmux split-window -dv -p 20'

" }}}
" vim-sneak Settings {{{

let g:sneak#s_next = 1

" }}}
" vim-smooth-scroll Settings {{{

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 100, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 100, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 100, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 100, 4)<CR>

" }}}
" miniBuffer {{{

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" }}}
" vim-pydoc {{{
let g:pydoc_cmd = "/usr/bin/pydoc"
" }}}
" General Keyboard Settings {{{

let mapleader = "\<Space>"    " change mapleader

" }}}
