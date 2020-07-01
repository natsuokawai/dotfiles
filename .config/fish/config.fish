set -g theme_date_format "+ %H:%M"
set -g theme_date_timezone Asia/Tokyo

#==================================================
# alias
#==================================================

# git
alias g='git'

# docker
alias d='docker'
alias dc='docker-compose'

# aws
alias aws='docker run --rm -ti -v ~/.aws:/root/.aws -v $PWD:/aws amazon/aws-cli'

# tmux
alias ide='~/Workspace/commands/ide'
