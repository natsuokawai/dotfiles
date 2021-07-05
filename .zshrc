export LANG=ja_JP.UTF-8

alias d="docker"
alias dc="docker compose"
alias g="git"

alias zshrc="vi ~/.zshrc"
alias vimrc="vi ~/.vimrc"

autoload -Uz colors
colors

setopt auto_cd
function chpwd() {
  if (( ${+commands[exa]} )); then
    exa --icons
  else
    ls
  fi
}

setopt correct

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history

autoload -U compinit
compinit

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
