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
antigen bundle pyenv
antigen bundle autojump
antigen bundle Aloxaf/fzf-tab

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
alias ls="eza --icons=always"
alias proj="cd ~/Projects"
alias cd="z"
alias gfa="git_fetch_all"
alias gpa="git_pull_all"

# DDEV
alias artisan="ddev php artisan"
alias node="ddev exec node"
alias npm="ddev npm"
alias npx="ddev exec npx"
alias composer="ddev composer"
alias sql="ddev sequelace"
alias php="ddev php"
alias pest="ddev php ./vendor/bin/pest"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# path
export PATH="/Users/dan/.jetbrains:$PATH"
