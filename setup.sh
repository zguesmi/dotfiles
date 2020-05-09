#!/bin/bash


export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

function add_deb_repo() {
    local NAME=$1
    local REPO_URL=$2
    local GPG_URL=$3

    if [ ! -z $GPG_URL ]; then
        sudo curl -fsSL $GPG_URL | sudo apt-key --keyring /etc/apt/trusted.gpg.d/$NAME.gpg add -
    fi

    echo $REPO_URL | sudo tee /etc/apt/sources.list.d/$NAME.list && sudo apt-get update -q
}

#################
#  OS packags   #
#################
PACKAGES="apt-transport-https ca-certificates curl git gnupg-agent htop httpie jq nmap neofetch "
PACKAGES+="powerline software-properties-common sdkman stow terminator tree unzip vim wget zip zsh"
printf "> Installing those OS packages:\n$PACKAGES\n"
sudo apt-get update -q && sudo apt-get install -q -y $PACKAGES

#################
#   Terminal    #
#################
printf "> Setting up terminal\n"
printf "> Configuring zsh as the default shell for user: $USER\n"
chsh -s $(which zsh)
printf "> Installing oh-my-zsh addons\n"
git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git 	zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone -q https://github.com/zsh-users/zsh-autosuggestions			zsh/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone -q https://github.com/Powerlevel9k/powerlevel9k.git 			zsh/.oh-my-zsh/custom/themes/powerlevel9k
git clone -q https://github.com/romkatv/powerlevel10k.git				zsh/.oh-my-zsh/custom/themes/powerlevel10k

#################
#   Dev tools   #
#################
printf "> Installing dev tools\n"
# Ansible
udo add-apt-repository --yes --update ppa:ansible/ansible && sudo apt-get install ansible
# Docker
sudo snap install docker
COMPOSE_BIN="https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)"
sudo curl -L $COMPOSE_BIN -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker user
# Nodejs
sudo snap install node --classic
npm install -q -g vtop express-generator
# Java
curl -s "https://get.sdkman.io" | bash
sdk install java 11.0.7.hs-adpt
sdk install gradle 5.5

#################
#  Desktop apps #
#################
printf "> Installing desktop apps:\n"
sudo snap instal gitkraken postman
sudo snap instal codium --classic
sudo snap instal slack --classic
# Brave
add_deb_repo "brave-browser" \
        "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
        "https://brave-browser-apt-release.s3.brave.com/brave-core.asc"
# Riot
add_deb_repo "riot-desktop" \
        "deb https://packages.riot.im/debian/ default main" \
        "https://packages.riot.im/debian/riot-im-archive-keyring.gpg"
# Shutter
sudo add-apt-repository --yes --update ppa:linuxuprising/shutter
sudo apt-get install brave-browser riot-desktop shutter
# Etcher
sudo apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61
add_deb_repo "balena-etcher" \
        "deb https://deb.etcher.io stable etcher"
sudo apt-get install -q -y balena-etcher-electron

#################
#   Dotfiles    #
#################
printf "> Populating dotfiles\n"
stow fonts && sudo fc-cache -fv
stow vscodium zsh git
