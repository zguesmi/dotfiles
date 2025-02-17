export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ohmyzsh
export ZSH="${XDG_CONFIG_HOME}/ohmyzsh"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    colored-man-pages git zsh-autosuggestions zsh-syntax-highlighting
    # docker docker-compose
)

source ${ZSH}/oh-my-zsh.sh
[[ ! -f "${XDG_CONFIG_HOME}/p10k.zsh" ]] || source "${XDG_CONFIG_HOME}/p10k.zsh"

# aliases
[ -f ~/dotfiles/.aliases ] && source ~/dotfiles/.aliases

# nvm
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# fzf
FZF_DEFAULT_OPTS="--preview 'batcat --style=numbers,changes --color=always --line-range :500 {}'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height 90% --layout=reverse --border"

# bat
# ln -s /usr/bin/batcat ~/.local/bin/bat
# export BAT_STYLE="--style=numbers,changes"

# Source other aliases.
export IEXEC_DEV="${HOME}/iexec/dev"
[ -d "${IEXEC_DEV}/iexec-deploy" ] && source ${IEXEC_DEV}/iexec-deploy/devtools/.aliases
