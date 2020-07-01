"==================================================
" Plugins
"==================================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'thinca/vim-ref'
Plug 'tpope/vim-endwise'
call plug#end()

" NERDTree
map <C-n> :NERDTreeToggle<CR>


"==================================================
" Appearance
"==================================================
let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'
let g:airline#extensions#tabline#enabled = 1

"==================================================
" Editor settings
"==================================================
syntax on
set tabstop=2
set incsearch
set number


"==================================================
" Key mapping
"==================================================
inoremap <C-c> <Esc>
noremap <S-h> ^
noremap <S-l> $

"disable cursor key
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

"insertmode key move
inoremap <C-j>  <down>
inoremap <C-k>  <up>
inoremap <C-h>  <left>
inoremap <C-l>  <right>

"split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

"move window
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l

"airline keybinding
nmap <C-h> <Plug>AirlineSelectPrevTab
nmap <C-l> <Plug>AirlineSelectNextTab
