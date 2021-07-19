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

## git
alias g="git"
alias gad="git add"
alias gco="git checkout"
alias gcm="git commit"
alias gd="git diff"
alias gs="git status"

## docker
alias d="docker"
alias dc="docker compose"

## rails
alias rs="bundle exec rails server"
alias rc="bundle exec rails console"
alias rsp="bundle exec rspec"

##################################################
# basic                                          #
##################################################
export LANG=ja_JP.UTF-8

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

PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color}(%*%) %~
%# "

RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

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

zplug "peterhurford/git-aliases.zsh"
zplug "plugins/git",   from:oh-my-zsh
zplug "zplug/zplug", hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'

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
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)" 

## mysql
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

## nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

## ghcup
export PATH="$HOME/.ghcup/bin:$PATH"
