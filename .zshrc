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

## DDEV
alias artisan="ddev php artisan"
alias node="ddev exec node"
alias npm="ddev npm"
alias npx="ddev exec npx"
alias composer="ddev composer"
alias sql="ddev sequelace"
alias php="ddev php"
alias pest="ddev php ./vendor/bin/pest"
## End DDEV Aliases

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

# mise
eval "$(/Users/dan/.local/bin/mise activate zsh --shims)"

## DDEV Aliases Toggle
function toggle_ddev_aliases() {
    local start_marker="## DDEV"
    local end_marker="## End DDEV Aliases"
    local toggled_aliases=0

    # Read the .zshrc file line by line
    while IFS= read -r line; do
        # If the line is the start marker, begin toggling
        if [[ "$line" == "$start_marker" ]]; then
            toggled_aliases=1
            echo "$line"
            continue
        fi

        # If the line is the end marker, stop toggling
        if [[ "$line" == "$end_marker" ]]; then
            toggled_aliases=0
            echo "$line"
            continue
        fi

        # Toggle the lines between start and end markers
        if (( toggled_aliases )); then
            if [[ "$line" =~ ^#alias ]]; then
                echo "${line#\#}"
            elif [[ "$line" =~ ^alias ]]; then
                echo "#$line"
            else
                echo "$line"
            fi
        else
            echo "$line"
        fi
    done < ~/.zshrc > ~/.zshrc.tmp

    # Replace the original .zshrc with the modified version
    mv ~/.zshrc.tmp ~/.zshrc

    # Reload the .zshrc file
    source ~/.zshrc
}

[[ -s "/Users/dan/.gvm/scripts/gvm" ]] && source "/Users/dan/.gvm/scripts/gvm"

# Completions
autoload -Uz compinit && compinit

# DDEV
source "/Users/dan/.zsh/completions/ddev"
