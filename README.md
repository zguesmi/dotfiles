# dotfiles
I keep track of all my .dotfiles (shell, aliases, themes, vim...) here.
The `setup.sh` script automates all of the configuration I need whenever switching
on a new machine. I'll just `git clone` it and pipe it to bash (bash is internet explorer
of my terminal, it is only used to install **zsh**).

## Install zsh & configure OhMyZsh

Theme: powerline9k
Fonts: font-awesome
Plugins:
```
plugins=(
  git
  docker
  history
  colored-man-pages
  zsh-autosuggestions
  zsh-syntax-highlighting
)
```

Added manually
```
# shorten the length of the prompt
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
unsetopt nomatch

# add my alias files
if [ -f ~/.my_aliases ]; then
    source ~/.my_aliases
else
    print "404: '~/.my_aliases' not found."
fi


if [ -f ~/.iexec_aliases ]; then
    source ~/.iexec_aliases
else
    print "404: '~/.iexec_aliases' not found."
fi

alias code="code-insiders"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/zied/.sdkman"
[[ -s "/home/zied/.sdkman/bin/sdkman-init.sh" ]] && source "/home/zied/.sdkman/bin/sdkman-init.sh"

```

## Install