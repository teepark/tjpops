" An example for a vimrc file.
"
" Maintainer: Bram Moolenaar <Bram@vim.org>
" Last change: 2015 Mar 24
"
" To use it, copy it to
"  for Unix and OS/2:  ~/.vimrc
"  for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"  for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Bootstrap vim-plug
silent ![ -e ~/.config/nvim/autoload/plug.vim ] || ( mkdir -p ~/.config/nvim/autoload && fetch -q -o ~/.config/nvim/autoload/plug.vim https://github.com/junegunn/vim-plug/raw/master/plug.vim )

let g:python3_host_prog = '/usr/local/bin/python3'

" Load plugins
call plug#begin('~/.vim/plugged')
Plug 'cocopon/iceberg.vim'
Plug 'flazz/vim-colorschemes'  " additional color schemes
Plug 'mtth/scratch.vim'  " scratch buffer
Plug 'tpope/vim-surround'  " more text object types
Plug 'tpope/vim-endwise'  " auto-close language syntax
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }  " completion selector
Plug 'Shougo/neosnippet'  " snippets implementation
Plug 'Shougo/neosnippet-snippets'  " snippets data
Plug 'justinmk/vim-dirvish'  " directory browsing
Plug 'majutsushi/tagbar'  " tag bar
Plug 'neomake/neomake'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'idanarye/vim-merginal'
Plug 'mpetrov/vim-diffstat'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'saltstack/salt-vim', { 'for': 'sls' }
Plug 'fatih/vim-go', { 'for': 'go' }  " go
Plug 'deoplete-plugins/deoplete-go', { 'for': 'go', 'do': 'make' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }  " elm
Plug 'python-mode/python-mode', { 'for': 'python' }  " python
Plug 'zchee/deoplete-jedi', { 'for': 'python' }  " jedi-based autocomplete
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
call plug#end()
 
let g:pymode_options_max_line_length = 120
let g:pymode_warnings = 0
let g:pymode_folding = 1
let g:pymode_rope = 0
let g:pymode_rope_completion = 0  " deoplete-jedi got your back
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_lint_on_write = 0  " neomake handles linting
let g:pymode_run_bind = '<leader>r'
let g:pymode_breakpoint_bind = '<leader>b'

let g:elm_jump_to_error = 0
let g:elm_make_output_file = "elm.js"
let g:elm_make_show_warnings = 0
let g:elm_syntastic_show_warnings = 0
let g:elm_browser_command = ""
let g:elm_detailed_complete = 0
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 0
let g:elm_setup_keybindings = 1

if !exists('g:python_flake_version')
  let g:python_flake_version = 3
endif

if !exists('g:mypy_follow_imports')
  let g:mypy_follow_imports = 'skip'
endif

let g:neomake_python_flake8_maker = {
  \ 'exe': '/usr/local/bin/flake8-3.6',
  \ 'errorformat':
    \ '%E%f:%l: could not compile,%-Z%p^,' .
    \ '%A%f:%l:%c: %t%n %m,' .
    \ '%A%f:%l: %t%n %m,' .
    \ '%-G%.%#',
  \ }
let g:neomake_python_mypy_maker = {
  \ 'exe': '/usr/local/bin/mypy',
  \ 'args': ['--follow-imports=' . g:mypy_follow_imports, '--ignore-missing-imports'],
  \ 'errorformat':
    \ '%E%f:%l:%c: error: %m,' .
    \ '%W%f:%l:%c: warning: %m,' .
    \ '%I%f:%l:%c: note: %m,' .
    \ '%E%f:%l: error: %m,' .
    \ '%W%f:%l: warning: %m,' .
    \ '%I%f:%l: note: %m' ,
  \ }
let g:neomake_python_pylint_maker = {
  \ 'args': [
      \ '--output-format=text',
      \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg} [{msg_id}]"',
      \ '--reports=no',
      \ '--py3k',
      \ '--disable=dict-values-not-iterating',
  \ ],
  \ 'errorformat':
      \ '%A%f:%l:%c:%t: %m,' .
      \ '%A%f:%l: %m,' .
      \ '%A%f:(%l): %m,' .
      \ '%-Z%p^%.%#,' .
      \ '%-G%.%#',
  \ 'postprocess': [
  \   function('neomake#postprocess#generic_length'),
  \   function('neomake#makers#ft#python#PylintEntryProcess'),
  \ ]}
let g:neomake_python_enabled_makers = ['flake8', 'mypy', 'pylint']

let g:elm_format_autosave = 0

let g:deoplete#enable_at_startup = 1
let g:deoplete#on_insert_editor = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns['default'] = '\h\w*'
let g:deoplete#omni#input_patterns = {}
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1

let g:pymode_paths = ['typestubs/', 'actions/', 'admins/', 'affirm-frontend/', 'affirm-users/', 'agents/', 'aliases/', 'applications/', 'ari-service/', 'auth/', 'bank_ledger/', 'bank_loan_sales/', 'bank_portal/', 'bankroutingdb/', 'batch/', 'blueprints/', 'build-tools/', 'business_logic/', 'capabilities/', 'cards/', 'charlotte/', 'charlotte4/', 'counters/', 'crm/', 'crypto/', 'data_migration/', 'debugapp/', 'docs/', 'employees/', 'event_bus/', 'experiments/', 'ext_services/', 'fpna/', 'fquid/', 'furnishing/', 'http/', 'identifier_events/', 'infra/', 'issuer/', 'login-flows/', 'login-sessions/', 'merchants-analytics/', 'merchants/', 'messages/', 'metadata/', 'ml/', 'models/', 'nosql_models/', 'orchestration/', 'pfm/', 'policy/', 'policy_store/', 'policy_tracking/', 'preferences/', 'promos/', 'reconciliation/', 'reports/', 'risk/', 'risk_offline/', 'roles/', 'search/', 'session/', 'signals/', 'sql-store/', 'testing-toolbox/', 'tokens/', 'toolbox/', 'tracking/', 'traintrack/', 'trainyard/', 'unity/', 'virtual_cards/', 'anywhere/']
let g:neosnippet#snippets_directory = "~/.vim/plugged/neosnippet-snippets/neosnippets"

let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
let g:neomake_go_gometalinter_maker = {
  \ 'args': [
  \   '--tests',
  \   '--enable-gc',
  \   '--concurrency=3',
  \   '--fast',
  \   '-D', 'aligncheck',
  \   '-D', 'dupl',
  \   '-D', 'gocyclo',
  \   '-D', 'gotype',
  \   '-D', 'gas',
  \   '-E', 'misspell',
  \   '-E', 'unused',
  \   '%:p:h',
  \ ],
  \ 'append_file': 0,
  \ 'errorformat':
  \   '%E%f:%l:%c:%trror: %m,' .
  \   '%W%f:%l:%c:%tarning: %m,' .
  \   '%E%f:%l::%trror: %m,' .
  \   '%W%f:%l::%tarning: %m'
  \ }


" vim-go
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_term_enabled = 1
let g:go_fold_enable = ['import']

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

command! -bang -nargs=* Rg
	\ call fzf#vim#grep(
	\   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
	\   <bang>0 ? fzf#vim#with_preview('up:60%')
	\           : fzf#vim#with_preview('right:50%:hidden', '?'),
	\   <bang>0)

command! -bang -nargs=? -complete=dir Files
	\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

set tags=./tags;/

" nice color scheme
set t_Co=256
colorscheme iceberg

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup   " do not keep a backup file, use versions instead
set noundofile " keep an undo file (undo changes after closing)
set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch  " do incremental searching
set number     " show line numbers
set shiftround " round hard tab width to 'shiftwidth' spaces
set wildignore+=*.pyc,*.sw?,*/.mypy_cache/*

let g:fzf_tags_command = 'ctags -R --exclude=*.json --exclude=*.js --exclude=.tox'

" make ctrlp ignore vendored dependencies
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](vendor|deps|node_modules|_build|build|public|bin)$',
  \ }

nnoremap <c-p> :<c-u>Files<cr>
nnoremap <leader>e :<c-u>Commands<cr>

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
"map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" pre-populate the \v modifier in search regexps
nnoremap / /\v
nnoremap ? ?\v

" re-implement * and # to prefix \v in the pattern
nnoremap * :<c-u>execute "normal! /\\v<" . expand("<cword>") . ">\<lt>cr>"<cr>
nnoremap # :<c-u>execute "normal! ?\\v<" . expand("<cword>") . ">\<lt>cr>"<cr>

" shortcut to clear search highlighting
nnoremap <leader>n :nohlsearch<cr>

" override python-mode's \r and use our own
nnoremap <leader>r :<c-u>execute "w\|split +term\\ ./%"<cr>

" quickfix and location list modifying shortcuts
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>
nnoremap <leader>cn :cnext<cr>
nnoremap <leader>cp :cprevious<cr>
nnoremap <leader>lo :lopen<cr>
nnoremap <leader>lc :lclose<cr>
nnoremap <leader>ln :lnext<cr>
nnoremap <leader>lp :lprevious<cr>

" arc helpers
nnoremap <leader>ad :<c-u>execute "w\|split +term\\ arc\\ diff"<cr>

nnoremap <leader>g :<c-u>Goyo<cr>
nnoremap <leader>s :<c-u>Gstatus<cr>
nnoremap <leader>m :<c-u>Merginal<cr>
nnoremap <leader>T :<c-u>TagbarToggle<cr>

function! AfterCTags(job_id, data, event)
  echo "ctags complete"
endfunction

nnoremap <leader>cs :call jobstart('ctags -R --exclude=*.json --exclude=*.js --exclude=*.css --exclude="@.gitignore" .', {'on_exit': 'AfterCTags'})<cr>
nnoremap <leader>cS :call jobstart('ctags -R --exclude=*.json --exclude=*.js --exclude=*.css .', {'on_exit': 'AfterCTags'})<cr>

set updatetime=500

" disable escape from insert mode (habit-building)
"inoremap <esc> <nop>
"noremap <c-c> <esc>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  autocmd BufWritePost * Neomake

  " respect code folding markers in vimscript files
  autocmd FileType vim setlocal foldmethod=marker

  " python-related shortcuts
  autocmd FileType python setlocal wrap
  autocmd FileType python nnoremap <buffer> <leader>t :<c-u>execute "w\|split +term\\ nosetests\\ -v\\ %"<cr>
  autocmd FileType python nnoremap <buffer> <leader>i :<c-u>execute "w\|split +term\\ ipython\\ -i\\ %"<cr>
  autocmd FileType python nnoremap <buffer> <leader>I :<c-u>execute "w\|split +term\\ python\\ setup.py\\ install"<cr>
  autocmd FileType python norm zR

  " vim-go shortcuts
  autocmd FileType go nnoremap <buffer> <leader>f :<c-u>GoFmt<cr>
  autocmd FileType go nnoremap <buffer> <leader>r :<c-u>GoRun<cr>
  autocmd FileType go nnoremap <buffer> <leader>t :<c-u>GoTest -v<cr>
  autocmd FileType go nnoremap <buffer> <leader>j :<c-u>GoAddTags<cr>
  autocmd FileType go nnoremap <buffer> <leader>d :<c-u>GoDoc<cr>
  autocmd FileType go nnoremap <buffer> <leader>D :<c-u>GoDeclsDir<cr>
  autocmd FileType go nnoremap <buffer> <leader>C :<c-u>GoCoverageToggle!<cr>
  autocmd FileType go nnoremap <buffer> <leader>a :<c-u>GoAlternate<cr>

  autocmd FileType go nnoremap <buffer> <leader>db :<c-u>GoDebugBreakpoint<cr>
  autocmd FileType go nnoremap <buffer> <leader>dN :<c-u>GoDebugStep<cr>
  autocmd FileType go nnoremap <buffer> <leader>do :<c-u>GoDebugStepOut<cr>
  autocmd FileType go nnoremap <buffer> <leader>dn :<c-u>GoDebugNext<cr>
  autocmd FileType go nnoremap <buffer> <leader>dc :<c-u>GoDebugContinue<cr>
  autocmd FileType go nnoremap <buffer> <leader>dt :<c-u>GoDebugTest
  autocmd FileType go nnoremap <buffer> <leader>ds :<c-u>GoDebugStart
  autocmd FileType go nnoremap <buffer> <leader>dS :<c-u>GoDebugStop<cr>
  autocmd FileType go nnoremap <buffer> <leader>dr :<c-u>GoDebugRestart<cr>

  autocmd FileType go set shiftwidth=4
  autocmd FileType go set tabstop=4
  autocmd FileType go set softtabstop=0

  autocmd FileType javascript set expandtab
  autocmd FileType javascript set shiftwidth=2
  autocmd FileType javascript set tabstop=2
  autocmd FileType javascript set softtabstop=-1

  autocmd FileType elm set expandtab
  autocmd FileType elm set shiftwidth=4
  autocmd FileType elm set tabstop=4
  autocmd FileType elm set softtabstop=-1
  autocmd FileType elm nnoremap <buffer> <leader>f :<c-u>ElmFormat<cr>

  autocmd FileType sql set expandtab
  autocmd FileType sql set shiftwidth=4
  autocmd FileType sql set tabstop=4
  autocmd FileType sql set softtabstop=-1

  autocmd FileType elixir nnoremap <buffer> <leader>r :<c-u>!elixir %<cr>
  autocmd FileType elixir nnoremap <buffer> <leader>c :<c-u>!elixirc %<cr>
  autocmd FileType elixir nnoremap <buffer> <leader>i :<c-u>term iex %<cr>

  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!

  augroup END

else

  set autoindent " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif
