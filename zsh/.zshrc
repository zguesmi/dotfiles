export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ohmyzsh
export ZSH="${XDG_CONFIG_HOME}/oh-my-zsh"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    colored-man-pages docker docker-compose git nvm sdk
    # vscode
    zsh-autosuggestions zsh-syntax-highlighting
)

source ${ZSH}/oh-my-zsh.sh
[[ ! -f "${XDG_CONFIG_HOME}/p10k.zsh" ]] || source "${XDG_CONFIG_HOME}/p10k.zsh"

export IEXEC_DEV="${HOME}/iexec/dev"
[ -d "${IEXEC_DEV}/iexec-deploy" ] && source ${IEXEC_DEV}/iexec-deploy/core-dev/dot.bash_aliases

# aliases
[ -f ~/dotfiles/.aliases ] && source ~/dotfiles/.aliases

# sdkman
export SDKMAN_DIR="${XDG_CONFIG_HOME}/sdkman"
[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

# nvm
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# fzf
FZF_DEFAULT_OPTS="--preview 'batcat --style=numbers,changes --color=always --line-range :500 {}'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height 90% --layout=reverse --border"
# TODO vim plugin

# bat
# ln -s /usr/bin/batcat ~/.local/bin/bat
# export BAT_STYLE="--style=numbers,changes"

# z
Z_DIR="${XDG_CONFIG_HOME}/z"
[ -s "$NVM_DIR/z.sh" ] && source "$NVM_DIR/z.sh"

# .env
[ -f ~/dotfiles/.env ] && source ~/dotfiles/.env
