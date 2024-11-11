# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

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

# Custom aliases
alias ls="eza --icons=always"
alias proj="cd ~/Projects"
alias cd="z"
alias gfa="git_fetch_all"
alias gpa="git_pull_all"
alias lg="lazygit"

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

# FZF
export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
--color=selected-bg:#51576d \
--multi"

# BAT
export BAT_THEME="Catppuccin Frappe"

# DDEV Aliases
function load_ddev_aliases() {
  if [[ -d ".ddev" ]]; then
    alias artisan="ddev php artisan"
    alias node="ddev exec node"
    alias npm="ddev npm"
    alias npx="ddev exec npx"
    alias composer="ddev composer"
    alias sql="ddev sequelace"
    alias php="ddev php"
    alias pest="ddev php ./vendor/bin/pest"
    alias redis="ddev redis"
    alias wp="ddev wp"
    alias drush="ddev drush"
  else
    unalias artisan node npm npx composer sql php pest redis wp drush 2>/dev/null
  fi
}

# Call the function when changing directories
function chpwd() {
  load_ddev_aliases
}

# Call the function initially
load_ddev_aliases
