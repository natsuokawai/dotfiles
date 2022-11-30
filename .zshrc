##################################################
# aliases                                        #
##################################################
if type exa > /dev/null; then
  alias ls="exa --icons"
fi
if type bat > /dev/null; then
  alias cat="bat"
fi

alias zshrc="vi ~/.zshrc"
alias vimrc="vi ~/.vimrc"
alias nvimconf="vi ~/.config/nvim/init.lua"
alias dein="vi ~/.config/nvim/dein.toml"

alias cl="clear"

alias vi="nvim"

## git
alias g="git"
alias gad="git add"
alias gco="git checkout"
alias gcm="git commit"
alias gd="git diff"
alias gst="git status"
alias gs="git status"
alias cpbr="git_current_branch | pbcopy" # copy current git branch name to clipboard
alias git_current_branch="git branch | sed  '/^\*/!d;s/\* //'"

## docker
alias d="docker"
alias dc="docker compose"

## rails
alias be="bundle exec"
alias rs="bundle exec rails server"
alias rc="bundle exec rails console"
alias rsp="bundle exec rspec"

##################################################
# basic                                          #
##################################################
export LANG=ja_JP.UTF-8
export LESS="-iRMXS"
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:~/bin
export PATH=$PATH:/opt/homebrew/bin

setopt auto_cd
function chpwd() { ls }

setopt correct
setopt auto_list
setopt auto_menu

## history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history

autoload -Uz colors && colors

##################################################
# functions                                      #
##################################################
alias google='_searchByGoogle'
_searchByGoogle () {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            str="$str${str:++}$i"
        done
    fi
    open https://www.google.co.jp/search\?lr=lang_en\&q\=$str
}

##################################################
# app setings                                    #
##################################################
## rbenv
if [ -e "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  alias ruby='unalias ruby bundle gem && eval "$(rbenv init -)" && ruby'
  alias bundle='unalias ruby bundle gem && eval "$(rbenv init -)" && bundle'
  alias gem='unalias ruby bundle gem && eval "$(rbenv init -)" && gem'
fi

## mysql
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

## ghcup
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

## go
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin

## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## asdf
. /usr/local/opt/asdf/libexec/asdf.sh

##################################################
# zinit                                          #
##################################################
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

### plugins
zinit ice wait"!0" atload"autoload -Uz compinit && compinit"
zinit light "zsh-users/zsh-completions"

zinit ice wait"!0" atload"_zsh_autosuggest_start"
zinit light "zsh-users/zsh-autosuggestions"

zinit ice wait'!0'; zinit light "zsh-users/zsh-syntax-highlighting"
zinit ice wait'!0'; zinit light "zdharma/history-search-multi-word"
zinit light "sindresorhus/pure"

##################################################
# profiling                                      #
##################################################
# To run profiling, put `zmodload zsh/zprof && zprof` in the first line of .zshenv and uncomment the following.
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi
