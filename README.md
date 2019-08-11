# dotfiles
I keep track of all my .dotfiles (shell, aliases, themes, vim...) here.
The `bootstrap.sh` script automates all of the configuration I need whenever switching
on a new machine. I'll just `git clone` it and pipe it to bash (bash is internet explorer
of my terminal, it is only used to install **zsh**).

## Install zsh & configure OhMyZsh

**Theme**: powerline9k
**Fonts**: font-awesome
**Plugins**:
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

#### Shorten the length of the prompt
```
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
unsetopt nomatch
```

#### Add my alias files
```
# on personal machine
if [ -f ~/.my_aliases ]; then
    source ~/.my_aliases
else
    print "404: '~/.my_aliases' not found."
fi

# on work machine
if [ -f ~/.work_aliases ]; then
    source ~/.work_aliases
else
    print "404: '~/.work_aliases' not found."
fi

alias code="code-insiders"
```

#### Nodejs
Install nvm and install node
```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

#### Java
Install sdkman and istall java
```
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/zied/.sdkman"
[[ -s "/home/zied/.sdkman/bin/sdkman-init.sh" ]] && source "/home/zied/.sdkman/bin/sdkman-init.sh"

```

## Install dependencies, Code editor, tools...
- vim bootstrap
- docker
- git
- htop
- guake
- terminator
- vscode

## Setup vscode
Install extensions: python, spellcheck, java (lombok), spring-boot, vscode-icons... 