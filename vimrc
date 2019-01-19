" =================
" ==== PLUGINS ====

" Plugin manager is Vim-Plug: https://github.com/junegunn/vim-plug

call plug#begin('~/.vim/plugged')

" Utils
Plug 'airblade/vim-gitgutter' " show git diff in sign column
" Plug 'ctrlpvim/ctrlp.vim' " fuzzy file finde
Plug 'elzr/vim-json', { 'for': 'json' } " json highlighting
Plug 'honza/vim-snippets' " snippet files
Plug 'Raimondi/delimitMate' "automatic closing of surrounds
Plug 'scrooloose/nerdtree' " amazing file explorer
Plug 'sirver/ultisnips'
Plug 'ntpeters/vim-better-whitespace' " whitespace management
Plug 'nvie/vim-flake8' " python checker

" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } " Golang amazingness

" tpope
Plug 'tpope/vim-commentary' " comment stuff out
Plug 'tpope/vim-fugitive' " git tool set
Plug 'tpope/vim-repeat' " allow dot repeat in plugins
Plug 'tpope/vim-surround' " easy modify surrounds

" JavaScript
Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' } " indent support
Plug 'othree/yajs.vim', { 'for': 'javascript' } " syntax plugin
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' } " ES6 and beyond syntax
Plug 'mxw/vim-jsx', { 'for': ['jsx', 'javascript'] } " JSX support

" Visual aides
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " distraction-free writing
Plug 'fatih/molokai' " color scheme
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' } " focus tool
" Plug 'itchyny/lightline.vim' " status bar
Plug 't9md/vim-choosewin' " window label overlay

" Other - new
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'ervandew/supertab'
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'hashivim/vim-hashicorp-tools'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  SETTINGS                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Not vi
set nocompatible

" Enable filetype detection, plugin loading
filetype plugin indent on

" No swap file
set noswapfile

" Search into subfolders; tab-completion for files
set path +=**

" Prefer Unix over Windows over OS 9 formats
set fileformats=unix,dos,mac

" Display matching files when tab complete
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
	set wildignore+=.git\*,.hg\*,.svn\*
else
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Copy indent from current line
set autoindent

" Add indent based on surrounding code
set smartindent

" Show command when typed
set showcmd

" Set CWD automatically based on current file
autocmd BufEnter * silent! lcd %:p:h

set updatetime=300
set pumheight=10   " Completion window max size          "
set conceallevel=2 " Concealed text is completely hidden "

" colors
syntax enable
set t_Co=256
let g:rehash256 = 1
set background=dark
let g:molokai_original = 1
colorscheme molokai

" Auto-reload files changed outside vim
set autoread

" A better backspace
set backspace=indent,eol,start

" Case-insensitive searching
set ignorecase

" Case-sensitive search if upper case letter
set smartcase

" Turn on line numbering
set number

" Set relative line numbering
set relativenumber

" Highlight current line
set cursorline

" Show match while typing
set incsearch

" Highlight found searches
set hlsearch

" Enable mouse
set mouse=a

" Higlhight search
set hls

" Wrap text at word boundary
set wrap
set lbr
set showbreak=&

set laststatus=2

" Default
set encoding=utf-8

" toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:°,extends:»,precedes:«

" Split right of current window
set splitright

" Split below of current window
set splitbelow

" Automatic saving
set autowrite

" Hide buffer when abandoned
set hidden

" Save Vim info on exit
set viminfo='1000

" increase max memory to show syntax highlighting for large files
set maxmempattern=20000

" Dont show status since it's in lighline
set noshowmode

" Change complete menu behavior
set completeopt=menu,menuone

set lazyredraw

 " No sounds on errors
set noerrorbells
set novisualbell
" set t_vb=

set history=500
set nostartofline
set confirm

" avoid many cases of having to press enter to continue
set cmdheight=2

" toggle between 'paste' and 'nopaste'
nnoremap <F12> :set invpaste paste?<CR>
imap <F12> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F12>

" Tab control
set noexpandtab             " insert tabs rather than spaces for <Tab>
set smarttab                " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4               " the visible width of tabs
set softtabstop=4           " edit as if the tabs are 4 characters wide
set shiftwidth=4            " number of spaces to use for indent and unindent
set shiftround              " round indent to a multiple of 'shiftwidth'


if !has('nvim')
  set ttymouse=xterm2
  set ttyscroll=3
endif

set ttyfast                 " faster redrawing
set scrolloff=3             " lines of text around cursor

set diffopt+=vertical


set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion


if has('persistent_undo')
  set undofile
  set undodir=~/.cache/vim
endif

" Windows
if has("windows")
	set guifont=Consolas:h15:cANSI
	au GUIEnter * simalt ~x
endif

augroup filetypedetect
  command! -nargs=* -complete=help Help vertical belowright help <args>
  autocmd FileType help wincmd L
  
  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.hcl setf conf
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 

  autocmd BufRead,BufNewFile *.gotmpl set filetype=gotexttmpl
  
  autocmd BufNewFile,BufRead *.ino setlocal noet ts=4 sw=4 sts=4
  autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.html setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.proto setlocal expandtab shiftwidth=2 tabstop=2
  
  autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
augroup END

" print path
map <C-f> :echo expand("%:p")<cr>

" automatic saving and restoring of folds
set viewdir=$HOME/.vim/.vimview//
autocmd BufWrite * mkview
autocmd BufRead * silent loadview

" quick insert character to end of line
imap <F1> <Esc>v`^me<Esc>gi<C-o>:call Ender()<CR>
function! Ender()
  let endchar = nr2char(getchar())
  execute "normal \<End>a".endchar
  normal `e
endfunction


nnoremap <silent> <Leader>df :call DiffToggle()<CR>

function! DiffToggle()
    if &diff
        windo diffoff
    else
        windo diffthis
    endif
:endfunction

" Choose python3
let g:pymode_python = 'python3'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  MAPPINGS                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Example to load your own snippet sans plugin
" nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>

" Set leader key
let mapleader = ","

" copy to clipboard
map <C-c> "+y<CR>

" yank and paste in visual mode
vmap <silent> ,y y:new<CR>:call setline(1,getregtype())<CR>o<Esc>P:wq! ~/reg.txt<CR>
nmap <silent> ,y :new<CR>:call setline(1,getregtype())<CR>o<Esc>P:wq! ~/reg.txt<CR>
map <silent> ,p :sview ~/reg.txt<CR>"zdddG:q!<CR>:call setreg('"', @", @z)<CR>p
map <silent> ,P :sview ~/reg.txt<CR>"zdddG:q!<CR>:call setreg('"', @", @z)<CR>P

" omnicompletion
inoremap <C-@> <C-x><C-o>

" quickfix see next/previous
map <C-n> :cn<CR>
map <C-m> :cp<CR>

" quickfix close
nnoremap <leader>a :cclose<CR>

" Close all but current window
nnoremap <leader>o :only<CR>

" Close current screen
nnoremap <leader>x :clo<CR>

" save and exit
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q<CR>
" nnoremap <silent> <leader>q :q!<CR>

" exit insert mode
inoremap jj <esc>

" reload and edit vimrc
nnoremap <F5> :source $MYVIMRC<CR>
nnoremap <leader><F5> :edit $MYVIMRC<CR>

" switch tab left and right
nnoremap <F7> :tabprevious<CR>
nnoremap <F8> :tabnext<CR>

" Toggle highlight from searches
nnoremap <leader>/ :set hlsearch!<CR>

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Center the screen
nnoremap <space> zz

" Center search on screen
nnoremap n nzzzv
nnoremap N Nzzzv

" Center serch on paragraph move
nnoremap { {zzzv
nnoremap } }zzzv

" Center search on scroll down/up
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Save and restore session
map <F2> :mksession! ~/vim_session<CR>
map <F3> :source ~/vim_session<CR>

" Toggle spell check
map <leader>S :setlocal spell!<cr>
"
" Remove trailing white space
" nmap <leader>t :%s/\s\+$<cr>
nmap <Leader>t :StripWhitespace<CR>

" Paste from clipboard Windows
if has("windows")
	nmap <Leader>p <S-Insert>
endif

" Disable arrow keys, up/down moves line
no <down> ddp
no <up> ddkP
no <left> <Nop>
no <right> <Nop>
ino <down> <Nop>
ino <up> <Nop>
ino <left> <Nop>
ino <right> <Nop>
vno <down> <Nop>
vno <up> <Nop>
vno <left> <Nop>
vno <right> <Nop>

" yank and paste btw sessions
let g:session_yank_file="~/.vim_yank"
map <silent> <Leader>y :call Session_yank()<CR>
vmap <silent> <Leader>y y:call Session_yank()<CR>
vmap <silent> <Leader>Y Y:call Session_yank()<CR>
nmap <silent> <Leader>p :call Session_paste("p")<CR>
nmap <silent> <Leader>P :call Session_paste("P")<CR>

function Session_yank()
  new
  call setline(1,getregtype())
  put
  silent exec 'wq! ' . g:session_yank_file
  exec 'bdelete ' . g:session_yank_file
endfunction

function Session_paste(command)
  silent exec 'sview ' . g:session_yank_file
  let l:opt=getline(1)
  silent 2,$yank
  if (l:opt == 'v')
    call setreg('"', strpart(@",0,strlen(@")-1), l:opt) " strip trailing endline ?
  else
    call setreg('"', @", l:opt)
  endif
  exec 'bdelete ' . g:session_yank_file
  exec 'normal ' . a:command
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                delimitMate                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 GitGutter                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ]h :GitGutterNextHunk<CR>
nmap [h :GitGutterPrevHunk<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Goyo                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>m :Goyo<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 limelight                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Activate limelight in Goyo mode
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 flake8                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:flake8_quickfix_height=7
let g:flake8_show_in_gutter=1  " show
let g:flake8_show_in_file=1  " show marks in the file
autocmd BufWritePost *.py call Flake8() " run every time write to file

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 UltiSnips                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ultisnips has native support for SuperTab. SuperTab does omnicompletion by
" pressing tab. I like this better than autocompletion, but it's still fast.
let g:SuperTabDefaultCompletionType = "context"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"  
let g:UltiSnipsJumpBackwardTrigger="<s-tab>" 

" function! g:UltiSnips_Complete()
" 	call UltiSnips#ExpandSnippet()
" 	if g:ulti_expand_res == 0
" 		if pumvisible()
" 			return "\<C-n>"
" 		else
" 			call UltiSnips#JumpForwards()
" 			if g:ulti_jump_forwards_res == 0
" 				return "\<TAB>"
" 			endif
" 		endif
" 	endif
" 	return ""
" endfunction

" function! g:UltiSnips_Reverse()
" 	call UltiSnips#JumpBackwards()
" 	if g:ulti_jump_backwards_res == 0
" 		return "\<C-P>"
" 	endif

" 	return ""
" endfunction


" if !exists("g:UltiSnipsJumpForwardTrigger")
" 	let g:UltiSnipsJumpForwardTrigger = "<tab>"
" endif

" if !exists("g:UltiSnipsJumpBackwardTrigger")
" 	let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" endif

" " disable below causing issues
" " au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                                   CtrlP                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'

"let g:ctrlp_switch_buffer = 'et'  " jump to a file if it's open already
"let g:ctrlp_mruf_max=450    " number of recently opened files
"let g:ctrlp_max_files=0     " do not limit the number of searchable files
"let g:ctrlp_use_caching = 1
"let g:ctrlp_clear_cache_on_exit = 0
"let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
"let g:ctrlp_match_window = 'bottom,order:btt,max:10,results:10'
"let g:ctrlp_buftag_types = {'go' : '--language-force=go --golang-types=ftv'}
"let g:ctrlp_working_path_mode = 'ra'

"nmap <C-b> :CtrlPCurWD<cr>
"imap <C-b> <esc>:CtrlPCurWD<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   vim-go                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" show go declarations
nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)
autocmd FileType go nmap <silent> <Leader>d <Plug>(go-doc)
autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_snippet_case_type = "camelcase"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "5s"
let g:go_decls_includes = "func,type"
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_autodetect_gopath = 1
let g:go_highlight_build_constraints = 1

" create a go doc comment based on the word under the cursor
function! s:create_go_doc_comment()
	norm "zyiw
	execute ":put! z"
	execute ":norm I// \<Esc>$"
endfunction
nnoremap <leader>ui :<C-u>call <SID>create_go_doc_comment()<CR>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  vim-json                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" let g:vim_json_syntax_conceal = 0
autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2

" ==================== choosewin ==================

let g:choosewin_overlay_enable = 1
nmap  -  <Plug>(choosewin)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  NerdTree                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>
let NERDTreeShowHidden=1
let g:NERDTreeMouseMode = 2
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")
let NERDTreeShowBookmarks=1

" Start NerdTree automatically if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  fugitive                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gb :Gblame<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                                 lightline                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" show status bar

"let g:lightline = {
"	\ 'active': {
"	\   'left': [ [ 'mode', 'paste'],
"	\             [ 'fugitive', 'filename', 'modified', 'ctrlpmark', 'go'] ],
"	\   'right': [ [ 'lineinfo' ],
"	\              [ 'percent' ],
"	\              [ 'fileformat', 'fileencoding', 'filetype' ] ]
"	\ },
"	\ 'component': {
"	\   'go': '%#goStatuslineColor#%{LightLineGo()}',
"	\ },
"	\ 'component_visible_condition': {
"	\ 'go': '(exists("*go#statusline#Show") && ""!=go#statusline#Show())'
"	\ },
"	\ 'component_function': {
"	\   'lineinfo': 'LightLineInfo',
"	\   'percent': 'LightLinePercent',
"	\   'modified': 'LightLineModified',
"	\   'filename': 'LightLineFilename',
"	\   'fileformat': 'LightLineFileformat',
"	\   'filetype': 'LightLineFiletype',
"	\   'fileencoding': 'LightLineFileencoding',
"	\   'mode': 'LightLineMode',
"	\   'fugitive': 'LightLineFugitive',
"	\   'ctrlpmark': 'CtrlPMark',
"	\ },
"	\ }

"function! LightLineModified()
"if &filetype == "help"
"	return ""
"elseif &modified
"	return "+"
"elseif &modifiable
"	return ""
"else
"	return ""
"endif
"endfunction

"function! LightLineFileformat()
"	return winwidth(0) > 70 ? &fileformat : ''
"endfunction

"function! LightLineFiletype()
"	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
"endfunction

"function! LightLineFileencoding()
"	return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
"endfunction

"function! LightLineInfo()
"	return winwidth(0) > 60 ? printf("%3d:%-2d", line('.'), col('.')) : ''
"endfunction

"function! LightLinePercent()
"	return &ft =~? 'vimfiler' ? '' : (100 * line('.') / line('$')) . '%'
"endfunction

"function! LightLineFugitive()
"	return exists('*fugitive#head') ? fugitive#head() : ''
"endfunction

"function! LightLineGo()
"	return exists('*go#statusline#Show') ? go#statusline#Show() : ''
"endfunction

"function! LightLineMode()
"	let fname = expand('%:t')
"	return fname == 'ControlP' ? 'CtrlP' :
"				\ &ft == 'vimfiler' ? 'VimFiler' :
"				\ winwidth(0) > 60 ? lightline#mode() : ''
"endfunction

"function! LightLineFilename()
"	let fname = expand('%:t')
"	if mode() == 't'
"		return ''
"	endif

"	return fname == 'ControlP' ? g:lightline.ctrlp_item :
"				\ &ft == 'vimfiler' ? vimfiler#get_status_string() :
"				\ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
"				\ ('' != fname ? fname : '[No Name]')
"endfunction

"function! LightLineReadonly()
"	return &ft !~? 'help' && &readonly ? 'RO' : ''
"endfunction

"function! CtrlPMark()
"	if expand('%:t') =~ 'ControlP'
"		call lightline#link('iR'[g:lightline.ctrlp_regex])
"		return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
"					\ , g:lightline.ctrlp_next], 0)
"	else
"		return ''
"	endif
"endfunction

"let g:ctrlp_status_func = {
"			\ 'main': 'CtrlPStatusFunc_1',
"			\ 'prog': 'CtrlPStatusFunc_2',
"			\ }

"function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
"	let g:lightline.ctrlp_regex = a:regex
"	let g:lightline.ctrlp_prev = a:prev
"	let g:lightline.ctrlp_item = a:item
"	let g:lightline.ctrlp_next = a:next
"	return lightline#statusline(0)
"endfunction

"function! CtrlPStatusFunc_2(str)
"	return lightline#statusline(0)
"endfunction


"=====================================================
"===================== STATUSLINE ====================

let s:modes = {
      \ 'n': 'NORMAL', 
      \ 'i': 'INSERT', 
      \ 'R': 'REPLACE', 
      \ 'v': 'VISUAL', 
      \ 'V': 'V-LINE', 
      \ "\<C-v>": 'V-BLOCK',
      \ 'c': 'COMMAND',
      \ 's': 'SELECT', 
      \ 'S': 'S-LINE', 
      \ "\<C-s>": 'S-BLOCK', 
      \ 't': 'TERMINAL'
      \}

let s:prev_mode = ""
function! StatusLineMode()
  let cur_mode = get(s:modes, mode(), '')

  " do not update higlight if the mode is the same
  if cur_mode == s:prev_mode
    return cur_mode
  endif

  if cur_mode == "NORMAL"
    exe 'hi! StatusLine ctermfg=236'
    exe 'hi! myModeColor cterm=bold ctermbg=148 ctermfg=22'
  elseif cur_mode == "INSERT"
    exe 'hi! myModeColor cterm=bold ctermbg=23 ctermfg=231'
  elseif cur_mode == "VISUAL" || cur_mode == "V-LINE" || cur_mode == "V_BLOCK"
    exe 'hi! StatusLine ctermfg=236'
    exe 'hi! myModeColor cterm=bold ctermbg=208 ctermfg=88'
  endif

  let s:prev_mode = cur_mode
  return cur_mode
endfunction

function! StatusLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! StatusLinePercent()
  return (100 * line('.') / line('$')) . '%'
endfunction

function! StatusLineLeftInfo()
 let branch = fugitive#head()
 let filename = '' != expand('%:t') ? expand('%:t') : '[No Name]'
 if branch !=# ''
   return printf("%s | %s", branch, filename)
 endif
 return filename
endfunction

exe 'hi! myInfoColor ctermbg=240 ctermfg=252'

" start building our statusline
set statusline=

" mode with custom colors
set statusline+=%#myModeColor#
set statusline+=%{StatusLineMode()}               
set statusline+=%*

" left information bar (after mode)
set statusline+=%#myInfoColor#
set statusline+=\ %{StatusLineLeftInfo()}
set statusline+=\ %*

" go command status (requires vim-go)
set statusline+=%#goStatuslineColor#
set statusline+=%{go#statusline#Show()}
set statusline+=%*

" right section seperator
set statusline+=%=

" filetype, percentage, line number and column number
set statusline+=%#myInfoColor#
set statusline+=\ %{StatusLineFiletype()}\ %{StatusLinePercent()}\ %l:%v
set statusline+=\ %*
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ==================== ag ====================
let g:ackprg = 'ag --vimgrep --smart-case'                                                   

" ==================== FZF ====================
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '~20%' }

" search 
nmap <C-p> :FzfHistory<cr>
imap <C-p> <esc>:<C-u>FzfHistory<cr>

" search across files in the current directory
nmap <C-b> :FzfFiles<cr>
imap <C-b> <esc>:<C-u>FzfFiles<cr>

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" ==== other plugins ====
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

nmap <Leader>gi <Plug>(grammarous-open-info-window)
nmap <Leader>gc <Plug>(grammarous-close-info-window)
nmap <Leader>gf <Plug>(grammarous-fixit)
