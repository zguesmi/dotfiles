# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/zied/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  osx
  ruby
  colored-man-pages
  virtualenv
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# added to activate syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# added to shorten the length of the prompt
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
unsetopt nomatch

# add my aliases file
if [ -f ~/.aliases ]; then
    source ~/.aliases
else
    print "404: '~/.aliases' file not found."
fi

# my ip address
myip() {
    ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
    ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
    ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
    ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
    ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}


# clipcp - Copy data to clipboard
#
# Usage:
#  <command> | clipcp    - copies stdin to clipboard
#  clipcp <file>         - copies a file's contents to clipboard

clipcp() {

    OSTYPE=$(uname)

    emulate -L zsh
    local file=$1
    if [[ $OSTYPE == darwin* ]]; then
        if [[ -z $file ]]; then
            pbcopy
        else
            cat $file | pbcopy
        fi
    elif [[ $OSTYPE == cygwin* ]]; then
        if [[ -z $file ]]; then
            cat > /dev/clipboard
        else
            cat $file > /dev/clipboard
        fi
    else
        if (( $+commands[xclip] )); then
            if [[ -z $file ]]; then
                xclip -in -selection clipboard
            else
                xclip -in -selection clipboard $file
            fi
        elif (( $+commands[xsel] )); then
            if [[ -z $file ]]; then
                xsel --clipboard --input
            else
                cat "$file" | xsel --clipboard --input
            fi
        else
            print "clipboard copying/pasting: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
            return 1
        fi
    fi
}

# clipps - "Paste" data from clipboard to stdout
#
# Usage:
#   clipps   - writes clipboard's contents to stdout
#   clipps | <command>    - pastes contents and pipes it to another process
#   clipps > <file>      - paste contents to a file

clipps() {

    OSTYPE=$(uname)

    emulate -L zsh
    if [[ $OSTYPE == darwin* ]]; then
        pbpaste
    elif [[ $OSTYPE == cygwin* ]]; then
        cat /dev/clipboard
    else
        if (( $+commands[xclip] )); then
            xclip -out -selection clipboard
        elif (( $+commands[xsel] )); then
            xsel --clipboard --output
        else
            print "clipboard copying/pasting: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
            return 1
        fi
    fi
}
