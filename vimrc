" Eduard Saller {{{
" This is the .vimrc of Eduard Saller
" Feel free to use what you want
" }}}
" TODO {{{
" More Documentation :D
" Reorder (maybe put shortcuts into the title)
" }}}
" Speedup {{{

set nocursorcolumn
set nocursorline
set synmaxcol=200
syntax sync minlines=512
set ttyfast
set ttyscroll=3
set lazyredraw

" }}}
" Shell Settings {{{
" set shell=/usr/local/bin/zsh
set shell=/bin/zsh
" }}}
" Vim Plug plugin manager {{{

" Hint: ruby often causes problems => uninstall vim => rvm system =>
" install vim
" Automatic Vim Plug install
if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall
    endif
" Installed Plugins {{{
call plug#begin('~/.vim/bundle')
" TODO: REORDER INTO CATEGORIES
" A tree explorer plugin for vim
Plug 'scrooloose/nerdtree'

" precision colorscheme for the vim text editor
Plug 'altercation/vim-colors-solarized'

" lean & mean status/tabline for vim that's light as air
" Plug 'bling/vim-airline'

" quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" wisely add "end" in ruby, endfunction/endif/more in vim script, etc
Plug 'tpope/vim-endwise'

" comment stuff out
Plug 'tpope/vim-commentary'

" The ultimate undo history visualizer for VIM
Plug 'mbbill/undotree'

" tmux basics
Plug 'tpope/vim-tbone'

" Fuzzy file, buffer, mru, tag, etc finder
Plug 'kien/ctrlp.vim'

" Syntax checking hacks for vim
Plug 'scrooloose/syntastic'

" a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" a Git mirror for Gundo
" Plug 'sjl/gundo.vim'

" Elegant buffer explorer - takes very little screen space
Plug 'fholgado/minibufexpl.vim'

" Vim plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'

" Better Rainbow Parentheses
Plug 'kien/rainbow_parentheses.vim'

" :shoe: The missing motion for Vim
Plug 'justinmk/vim-sneak'

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" Emoji in Vim (only terminal and mac)
Plug 'junegunn/vim-emoji'

" Writing Plugins {{{

" Disable clutter
Plug 'junegunn/goyo.vim'

" Highlight current block
Plug 'junegunn/limelight.vim'
" }}}

call plug#end()

" }}}

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
""set cursorline                  " Highlight the screen line of the cursor
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
" Solarized/Apprentice/Gruvbox/Molokai theme {{{


if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    color solarized
endif
    let g:solarized_termtrans=1
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"

"colorscheme apprentice
"colorscheme gruvbox
"colorscheme molokai

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
" UndoTree Settigns {{{

let g:undotree_WindowLayout = 2
nnoremap <F5> :UndotreeToggle<CR>

" }}}
" Goyo + Limelight {{{
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

function! s:goyo_enter()
  if has('gui_running')
    set fullscreen
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  " hi NonText ctermfg=101
  Limelight
endfunction

function! s:goyo_leave()
  if has('gui_running')
    set nofullscreen
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
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
" Commentary Settings {{{
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
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
let g:latex_fold_enabled = 0
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
let g:neocomplete#force_omni_input_patterns.java =
            \ '\%(\h\w*\|)\)\.\w*'



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
" miniBuffer {{{

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" }}}
" go to next/previous indentation level {{{
function! s:go_indent(times, dir)
  for _ in range(a:times)
    let l = line('.')
    let x = line('$')
    let i = s:indent_len(getline(l))
    let e = empty(getline(l))

    while l >= 1 && l <= x
      let line = getline(l + a:dir)
      let l += a:dir
      if s:indent_len(line) != i || empty(line) != e
        break
      endif
    endwhile
    let l = min([max([1, l]), x])
    execute 'normal! '. l .'G^'
  endfor
endfunction
nnoremap <silent> gi :<c-u>call <SID>go_indent(v:count1, 1)<cr>
nnoremap <silent> gpi :<c-u>call <SID>go_indent(v:count1, -1)<cr>
" }}}
" Buffer Search Function {{{
nnoremap <leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>
" }}}
" Shebang Function {{{
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
" }}}
" vim-pydoc {{{
let g:pydoc_cmd = "/usr/bin/pydoc"
" }}}
" Count Occurences of Pattern Function {{{
xnoremap <Leader>c :s@\%V@@gn<Left><Left><Left><Left>
nnoremap <Leader>c :%s@@@gn<Left><Left><Left><Left>
" }}}
" Google Funtion {{{
function! s:goog(pat)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system('open https://www.google.com/search?q='.q)
endfunction

nnoremap <leader>? :call <SID>goog(expand("<cWORD>"))<cr>
xnoremap <leader>? "gy:call <SID>goog(@g)<cr>gv
" }}}
" Emoji {{{

" %< Where to truncate
" %n buffer number
" %F Full path
" %m Modified flag: [+], [-]
" %r Readonly flag: [RO]
" %y Type:          [vim]
" fugitive#statusline()
" %= Separator
" %-14.(...)
" %l Line
" %c Column
" %V Virtual column
" %P Percentage
" %#HighlightGroup#
set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P
silent! if emoji#available()
  let s:ft_emoji = map({
    \ 'c':          'baby_chick',
    \ 'clojure':    'lollipop',
    \ 'coffee':     'coffee',
    \ 'cpp':        'chicken',
    \ 'css':        'art',
    \ 'eruby':      'ring',
    \ 'gitcommit':  'soon',
    \ 'haml':       'hammer',
    \ 'help':       'angel',
    \ 'html':       'herb',
    \ 'java':       'older_man',
    \ 'javascript': 'monkey',
    \ 'make':       'seedling',
    \ 'markdown':   'book',
    \ 'perl':       'camel',
    \ 'python':     'snake',
    \ 'ruby':       'gem',
    \ 'scala':      'barber',
    \ 'sh':         'shell',
    \ 'slim':       'dancer',
    \ 'text':       'books',
    \ 'vim':        'poop',
    \ 'vim-plug':   'electric_plug',
    \ 'yaml':       'yum',
    \ 'yaml.jinja': 'yum'
  \ }, 'emoji#for(v:val)')

  function! S_filetype()
    if empty(&filetype)
      return emoji#for('grey_question')
    else
      return get(s:ft_emoji, &filetype, '['.&filetype.']')
    endif
  endfunction

  function! S_modified()
    if &modified
      return emoji#for('kiss').' '
    elseif !&modifiable
      return emoji#for('construction').' '
    else
      return ''
    endif
  endfunction

  function! S_fugitive()
    if !exists('g:loaded_fugitive')
      return ''
    endif
    let head = fugitive#head()
    if empty(head)
      return ''
    else
      return head == 'master' ? emoji#for('crown') : emoji#for('dango').'='.head
    endif
  endfunction

  let s:braille = split('"⠉⠒⠤⣀', '\zs')
  function! Braille()
    let len = len(s:braille)
    let [cur, max] = [line('.'), line('$')]
    let pos  = min([len * (cur - 1) / max([1, max - 1]), len - 1])
    return s:braille[pos]
  endfunction

  hi def link User1 TablineFill
  let s:cherry = emoji#for('cherry_blossom')
  function! MyStatusLine()
    let mod = '%{S_modified()}'
    let ro  = "%{&readonly ? emoji#for('lock') . ' ' : ''}"
    let ft  = '%{S_filetype()}'
    let fug = ' %{S_fugitive()}'
    let sep = ' %= '
    let pos = ' %l,%c%V '
    let pct = ' %P '

    return s:cherry.' [%n] %F %<'.mod.ro.ft.fug.sep.pos.'%{Braille()}%*'.pct.s:cherry
  endfunction

  " Note that the "%!" expression is evaluated in the context of the
  " current window and buffer, while %{} items are evaluated in the
  " context of the window that the statusline belongs to.
  set statusline=%!MyStatusLine()
endif
" }}}
" General Keyboard Settings {{{

let mapleader = "\<Space>"    " change mapleader


" }}}
