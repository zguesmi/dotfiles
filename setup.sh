#!/bin/bash


export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export ZSH="${XDG_CONFIG_HOME}/oh-my-zsh"
GR="\033[1;32m" # green
NC="\033[0m"    # no color

function log() {
    printf "\n${GR}>> ${1}${NC}\n"
}

function add_deb_repo() {
    local NAME=$1
    local REPO_URL=$2
    local GPG_URL=$3

    if [ ! -z $GPG_URL ]; then
        sudo curl -fsSL $GPG_URL | sudo apt-key --keyring /etc/apt/trusted.gpg.d/$NAME.gpg add -
    fi

    echo $REPO_URL | sudo tee /etc/apt/sources.list.d/$NAME.list
}

function apt_update_quiet() {
    sudo apt-get update > /dev/null
}

function apt_install_quiet() {
    sudo apt-get install -y $@ > /dev/null
}

function apt_update_install_quiet() {
    apt_update_quiet && apt_install_quiet
}

#################
#  OS packags   #
#################
PACKAGES="apt-transport-https ca-certificates curl git gnupg-agent guake htop httpie jq nmap neofetch "
PACKAGES+="powerline software-properties-common stow terminator tree unzip vim wget zip zsh"
log "Installing those OS packages:"
printf "${PACKAGES}\n"
apt_update_quiet && apt_install_quiet $PACKAGES

#################
#   Terminal    #
#################
log "Setting up terminal"
log "Configuring zsh as the default shell for user: $USER"
chsh -s $(which zsh)
log "Installing oh-my-zsh addons"
git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git 	${ZSH}/custom/plugins/zsh-syntax-highlighting
git clone -q https://github.com/zsh-users/zsh-autosuggestions			${ZSH}/custom/plugins/zsh-autosuggestions
git clone -q https://github.com/Powerlevel9k/powerlevel9k.git 			${ZSH}/custom/themes/powerlevel9k
git clone -q https://github.com/romkatv/powerlevel10k.git				${ZSH}/custom/themes/powerlevel10k
stow zsh

#################
#   Dev tools   #
#################
log "Installing dev tools"
# Ansible
sudo add-apt-repository --yes ppa:ansible/ansible > /dev/null && apt_update_install_quiet ansible
# Docker
sudo snap install docker
COMPOSE_BIN="https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)"
sudo curl -fsSL $COMPOSE_BIN -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker user
# Nodejs
# sudo snap install node --classic
# npm install -q -g vtop express-generator
# Java
curl -s "https://get.sdkman.io" | bash > /dev/null
source "${SDKMAN_DIR}/bin/sdkman-init.sh"
sdk install java 11.0.7.hs-adpt
sdk install gradle 5.5

#################
#  Desktop apps #
#################
log "Installing desktop apps"
sudo snap install codium --classic
sudo snap install gitkraken
sudo snap install postman
sudo snap install slack --classic
# Brave
add_deb_repo "brave-browser" \
        "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
        "https://brave-browser-apt-release.s3.brave.com/brave-core.asc"
# Riot
add_deb_repo "riot-desktop" \
        "deb https://packages.riot.im/debian/ default main" \
        "https://packages.riot.im/debian/riot-im-archive-keyring.gpg"
# Shutter
sudo add-apt-repository --yes ppa:linuxuprising/shutter > /dev/null
# Etcher
sudo apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61
add_deb_repo "balena-etcher" \
        "deb https://deb.etcher.io stable etcher"

apt_update_install_quiet brave-browser riot-desktop shutter balena-etcher-electron

#################
#   Dotfiles    #
#################
log "Populating dotfiles"
stow fonts && sudo fc-cache -f
stow vscodium git --ignore='*/.gitkeep'
# stow zsh
