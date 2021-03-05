"==================================================
" Plugins
"==================================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
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
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'ollykel/v-vim'
Plug 'slim-template/vim-slim'
Plug 'pangloss/vim-javascript'
Plug 'tidalcycles/vim-tidal'
call plug#end()

"NERDTree
map <C-n> :NERDTreeToggle<CR>

"fzf
map <C-s> :GFiles<CR>
map <C-y> :History<CR>

"ale
let g:ale_ruby_rubocop_executable = 'docker run --rm --volume "$PWD:/app" cagedata/rubocop'
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}

"tidalvim
let g:tidal_default_config = {"socket_name": "default", "target_pane": ":1.2"}

"==================================================
" Appearance
"==================================================
let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'
let g:airline#extensions#tabline#enabled = 1
let g:vim_markdown_folding_disabled = 1

autocmd BufNewFile,BufRead .irbrc  set filetype=ruby
autocmd BufNewFile,BufRead .pryrc  set filetype=ruby

"==================================================
" Editor settings
"==================================================
syntax on
set tabstop=2
set incsearch

set autoindent
set cindent
set expandtab
set number
set smartindent
set smarttab
set splitbelow

if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
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
