"==================================================
" Plugins
"==================================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'thinca/vim-ref'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'plasticboy/vim-markdown'
Plug 'pangloss/vim-javascript'
Plug 'dag/vim2hs'
call plug#end()

"
syntax enable
set background=dark
colorscheme solarized

"NERDTree
map <C-n> ;NERDTreeToggle<CR>

"fugitive
map <C-b> ;Gblame<CR>

"fzf
map <C-s> ;GFiles<CR>
map <C-y> ;History<CR>

noremap ; :
noremap : ;

"ale
let g:ale_ruby_rubocop_executable = 'docker run --rm --volume "$PWD:/app" cagedata/rubocop'
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}

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
set tabstop=2
set incsearch

set autoindent
set cindent
set expandtab
set number
set smartindent
set smarttab
set splitbelow

"run `vim --version | grep clipboard` and check if `+clipboard` is displayed
set clipboard+=unnamed 

if has("autocmd")
  filetype plugin on
  filetype indent on
  "sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtab
  autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType eruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType yaml        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
endif

let g:vim_markdown_new_list_item_indent = 2

if executable('rg')
    let &grepprg = 'rg --vimgrep --hidden'
    set grepformat=%f:%l:%c:%m
endif

"==================================================
" Key mapping
"==================================================
inoremap <C-c> <Esc>

"airline keybinding
nmap <C-h> <Plug>AirlineSelectPrevTab
nmap <C-l> <Plug>AirlineSelectNextTab

"==================================================
" Haskell
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
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gf <plug>(lsp-code-action)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <F2> <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    xmap <buffer> f <plug>(lsp-document-range-format)
    nmap <buffer> <F5> <plug>(lsp-code-lens)

    " buffer format on save
    " autocmd BufWritePre <buffer> LspDocumentFormatSync
endfunction

augroup lsp_install
    au!
    let g:lsp_signs_enabled = 1         " enable signs
    let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
    let g:lsp_signs_error = {'text': '✗'}
    " let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GUI
    " let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'} " icons require GUI
    let g:lsp_signs_warning = {'text': '‼'}
    let g:lsp_highlight_references_enabled = 1
    highlight link LspErrorText GruvboxRedSign " requires gruvbox
    highlight clear LspWarningLine
    " highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green
    highlight lspReference guibg=#303010

    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
