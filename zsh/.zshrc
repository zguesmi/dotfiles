# Path to your oh-my-zsh installation.
export ZSH="/home/${USER}/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source ~/powerlevel10k/powerlevel10k.zsh-theme
# ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="powerlevel9k/powerlevel9k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# # Shorten the length fo the prompt
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
# # Disable right prompt
# POWERLEVEL9K_DISABLE_RPROMPT=true
# unsetopt nomatch

plugins=(
    colored-man-pages
    # command-not-found
    # common-aliases
    docker
    docker-compose
    git
    # git-extras
    # history
    nvm
    sdk # java
    # vscode
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

[ -f ~/dotfiles/.aliases ] && source ~/dotfiles/.aliases

IEXECDEV=$HOME/iexecdev/iexec-deploy/core-dev/dot.bash_aliases
[ -f $IEXECDEV ] && source $IEXECDEV

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

################################################################################
# Terminal: Terminator
# Font: SourceCodePro+Powerline+Awesome Regular, 13
# OS: Ubuntu
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
