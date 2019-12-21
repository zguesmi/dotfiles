# Path to your oh-my-zsh installation.
export ZSH="/home/zied/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# shorten the length fo the prompt
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
unsetopt nomatch

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
    colored-man-pages
    # command-not-found
    common-aliases
    docker
    docker-compose
    git
    git-extras
    history
    nvm
    ruby
    sdk
    # virtualenv
    vscode
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# my alias files
[ -f ~/.aliases/personal.sh ] && source ~/.aliases/personal.sh
[ -f ~/.aliases/work.sh ] && source ~/.aliases/work.sh

# #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
