export ZSH=$HOME/.oh-my-zsh

# Oh-My-Zsh config
export ZSH=$HOME/.oh-my-zsh
# Control Oh-My-Zsh update checking
DISABLE_AUTO_UPDATE=false
UPDATE_ZSH_DAYS=1

# Zinit Plugin Manager
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

# Load custom plugins
. ~/.zsh/.zsh-plugins

plugins=(
  git
)

# Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
# Preferred editor
EDITOR='nvim'
fpath+=~/.zfunc

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Source aliases
[ -f "$HOME/.zsh_aliases" ] && source "$HOME/.zsh_aliases"

# Local overrides (per-host, secrets, etc.)
if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
