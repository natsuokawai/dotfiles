##################################################
# aliases                                        #
##################################################
if (( ${+commands[exa]} )); then
  alias ls="exa --icons"
fi
if (( ${+commands[bat]} )); then
  alias cat="bat"
fi

alias zshrc="vi ~/.zshrc && source ~/.zshrc"
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

setopt auto_cd
function chpwd() { ls }

setopt correct
setopt auto_list
setopt auto_menu

autoload -Uz compinit && compinit

## history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history


##################################################
# appearance                                     #
##################################################
autoload -Uz colors && colors

PROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
PROMPT=$PROMPT'${vcs_info_msg_0_}'
PROMPT=$PROMPT"
%# "

RPROMPT="%* %"
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=1

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
    open https://www.google.co.jp/search\?q\=$str
}

alias sbox='_scrapboxToday'
_scrapboxToday () {
    name=`date "+%Y-%m-%d"`
    open https://scrapbox.io/natsuokawai-diary/$name
}

alias memo='_scrapboxMemo'
_scrapboxMemo () {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            str="$str${str:+_}$i"
        done
    fi
    open https://scrapbox.io/natsuokawai/$str
}


##################################################
# zplug                                          #
##################################################
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=61,underline'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

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

## nvm
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  alias nvm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && nvm'
  alias node='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && node'
  alias npm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && npm'
fi

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
