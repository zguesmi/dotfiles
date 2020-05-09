# dotfiles
I "git clone" and "setup.sh" to reproduce my config on new machines

## Start by installing git and cloning the repo
```
cd ~
sudo apt-get update && sudo apt-get install -y git && \
    git clone https://github.com/zguesmi/dotfiles.git && \
    cd dotfiles && \
    bash setup.sh
```