export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ohmyzsh
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    colored-man-pages docker docker-compose git nvm sdk
    # vscode
    zsh-autosuggestions zsh-syntax-highlighting
)

source ${ZSH}/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# sdkman
export SDKMAN_DIR="${XDG_CONFIG_HOME}/.sdkman"
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh" # This loads nvm

# aliases
[ -f ~/dotfiles/.aliases ] && source ~/dotfiles/.aliases

# work
IEXECDEV=${HOME}/iexecdev/iexec-deploy/core-dev/dot.bash_aliases
[ -f ${IEXECDEV} ] && source ${IEXECDEV}
