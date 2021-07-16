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

autoload -U compinit
compinit

## history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history


##################################################
# appearance                                     #
##################################################
autoload -Uz colors
colors

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
