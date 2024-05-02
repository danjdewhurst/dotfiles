# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

# Load oh-my-zsh library
antigen use oh-my-zsh

# Bundles
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle nvm
antigen bundle npm
antigen bundle node
antigen bundle laravel
antigen bundle pyenv
# antigen bundle rust
antigen bundle wp-cli
antigen bundle redis-cli
# antigen bundle dotenv
# antigen bundle docker
antigen bundle autojump
antigen bundle Sparragus/zsh-auto-nvm-use

# Last bundle - syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

# Theme
antigen theme romkatv/powerlevel10k

# Load everything
antigen apply

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize

##########################################################
############## Custom stuff ##############################
##########################################################

# Easy start and stop mariadb and redis for when switching between docker
dbs() {
    if [ "$1" = "start" ]; then
        brew services start redis
        brew services start mariadb
        echo "Started Redis and MariaDB services."
    elif [ "$1" = "stop" ]; then
        brew services stop redis
        brew services stop mariadb
        echo "Stopped Redis and MariaDB services."
    else
        echo "Usage: dbs start|stop"
    fi
}

# Custom aliases
alias eza="ls"
alias artisan="php artisan"
alias proj="cd ~/Projects"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
