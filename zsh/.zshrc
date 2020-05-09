export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ohmyzsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    colored-man-pages docker docker-compose git nvm sdk
    # vscode
    zsh-autosuggestions zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# aliases
[ -f ~/dotfiles/.aliases ] && source ~/dotfiles/.aliases

# work
IEXECDEV=$HOME/iexecdev/iexec-deploy/core-dev/dot.bash_aliases
[ -f $IEXECDEV ] && source $IEXECDEV

################################################################################
# Theme: Custom (Terminator palette: "#263238:#ec407a:#8bc34a:#ffa726:#2196f3:#9575cd :#00bcd4:#eceff1:#617d8a:#ec407a:#9ccc65:#ffb74d:#42a5f5:#b39ddb:#26c6da:#ffffff")
# POWERLEVEL9K_MODE='awesome-patched'
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status context dir dir_writable vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
# POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="white"
# POWERLEVEL9K_STATUS_VERBOSE=false
# POWERLEVEL9K_TIME_BACKGROUND="black"
# POWERLEVEL9K_TIME_FOREGROUND="249"
# POWERLEVEL9K_TIME_FORMAT="%D{%H:%M} \uE12E"
# POWERLEVEL9K_COLOR_SCHEME='light'
# POWERLEVEL9K_VCS_GIT_ICON='\uE1AA'
# POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uE1AA'
# POWERLEVEL9K_HIDE_BRANCH_ICON=true
################################################################################
