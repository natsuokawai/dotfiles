"==================================================
" Plugins
"==================================================

let mapleader = "\<Space>"

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Common
"" Apperance
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" File
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter' " shows a git diff in the sign column

"" LSP/Linter
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'dense-analysis/ale' " Asynchronous Lint Engine
Plug 'thinca/vim-ref' " Reference viewer

"" Testing
Plug 'vim-test/vim-test'
Plug 'tpope/vim-dispatch'

"" Others
Plug 'mattn/vim-lexiv' "Auto close parentheses
Plug 'thinca/vim-quickrun'
Plug 'plasticboy/vim-markdown'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'jparise/vim-graphql'

" Language specific
"" Ruby / Rails
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'pangloss/vim-javascript'
Plug 'vim-ruby/vim-ruby'

"" Javasctip/Typescript/React
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

"" Haskell
" Plug 'dag/vim2hs'

"" Rust
" Plug 'rust-lang/rust.vim'

"" Go
" Plug 'sebdah/vim-delve', { 'for': ['go'] }
call plug#end()

"
syntax enable
set background=dark

"NERDTree
map <C-t> ;NERDTreeToggle<CR>

"fugitive
map <C-b> ;Git blame<CR>

"fzf
map <C-s> ;GFiles<CR>
map <C-y> ;History<CR>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --no-ignore-vcs --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

"ale
"let g:ale_ruby_rubocop_executable = 'docker run --rm --volume "$PWD:/app" cagedata/rubocop'
let g:ale_linters = {
\   'ruby': ['rubocop'],
\   'haskell': ['hls'],
\}
let g:ale_linters_explicit = 1 
let g:airline#extensions#ale#enabled = 1

let js_fixers = ['prettier', 'eslint']
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': js_fixers,
\  'javascript.jsx': js_fixers,
\  'typescript': js_fixers,
\  'typescriptreact': js_fixers,
\  'css': ['prettier'],
\  'json': ['prettier'],
\}
let g:ale_fix_on_save = 1

"vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

" rust.vim
let g:rust_clip_command = 'pbcopy'

" vim-test
nnoremap <silent> <leader>t :TestNearest<CR>
nnoremap <silent> <leader>T :TestFile<CR>
nnoremap <silent> <leader>a :TestSuite<CR>
nnoremap <silent> <leader>l :TestLast<CR>
nnoremap <silent> <leader>g :TestVisit<CR>
let test#strategy = "dispatch"

" quick-run
nnoremap <silent> <leader>r :QuickRun<CR>

"==================================================
" Appearance
"==================================================
let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'
let g:airline#extensions#tabline#enabled = 1
let g:vim_markdown_folding_disabled = 1

autocmd BufNewFile,BufRead .irbrc  set filetype=ruby
autocmd BufNewFile,BufRead .pryrc  set filetype=ruby
autocmd BufNewFile,BufRead .jbuilder  set filetype=ruby

"==================================================
" Editor settings
"==================================================
lan en_US
set tabstop=2
set incsearch

set autoindent
set cindent
set expandtab
set number
set smartindent
set smarttab
set splitbelow

" for US keyboard layout
noremap ; :
noremap : ;

"run `vim --version | grep clipboard` and check if `+clipboard` is displayed
set clipboard+=unnamed 

if has("autocmd")
  filetype plugin on
  filetype indent on
  "sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtab
  autocmd FileType c                setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp              setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html             setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby             setlocal sw=2 sts=2 ts=2 et
  autocmd FileType javascript       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType javascriptreact  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType typescript       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType typescriptreact  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType go               setlocal sw=2 sts=2 ts=2 et
  autocmd FileType eruby            setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haskell          setlocal sw=2 sts=2 ts=2 et
  autocmd FileType yaml             setlocal sw=2 sts=2 ts=2 et
  autocmd FileType python           setlocal sw=4 sts=4 ts=4 et
endif

let g:vim_markdown_new_list_item_indent = 2

if executable('rg')
    let &grepprg = 'rg --vimgrep'
    set grepformat=%f:%l:%c:%m
endif
autocmd QuickFixCmdPost *grep* cwindow

"==================================================
" Key mapping
"==================================================
inoremap <C-c> <Esc>

"airline keybinding
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab

"==================================================
" vim-lsp
"==================================================
if (executable('haskell-language-server-wrapper'))
  au User lsp_setup call lsp#register_server({
      \ 'name': 'haskell-language-server-wrapper',
      \ 'cmd': {server_info->['haskell-language-server-wrapper', '--lsp']},
      \ 'whitelist': ['haskell'],
      \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd BufWritePre <buffer> LspDocumentFormatSync

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!

    let g:lsp_signs_enabled = 1         " enable signs
    let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
    let g:lsp_signs_error = {'text': '✗'}
    let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GUI
    let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'} " icons require GUI
    let g:lsp_signs_warning = {'text': '‼'}
    let g:lsp_highlight_references_enabled = 1
    highlight link LspErrorText GruvboxRedSign " requires gruvbox
    highlight clear LspWarningLine
    highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green
    highlight lspReference guibg=#303010

    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"==================================================
" Ruby
"==================================================
" Run followig commands in a shell for code-jump in vim.
" % brew install ctags
" % gem install gem-ctags
" % gem ctags
" % mkdir -p ~/.rbenv/plugins
" % git clone git://github.com/tpope/rbenv-ctags.git ~/.rbenv/plugins/rbenv-ctags
" % rbenv ctags
