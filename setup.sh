#!/bin/bash


export XDG_CONFIG_HOME="$HOME/.config"
# export XDG_CACHE_HOME="$HOME/.cache"
export ZSH="${XDG_CONFIG_HOME}/oh-my-zsh"
GR="\033[1;32m" # green
YE="\033[1;33m" # yellow
BL="\033[1;34m" # blue
NC="\033[0m"    # no color

function log_top_level() {
    printf "\n${YE}    <><> ${1}${NC}\n\n"
}

function log() {
    printf "${GR}* ${1}${NC}\n"
}

function add_deb_repo() {
    local NAME=$1
    local REPO_URL=$2
    local GPG_URL=$3

    if [ ! -z $GPG_URL ]; then
        sudo curl -fsSL $GPG_URL | sudo apt-key --keyring /etc/apt/trusted.gpg.d/$NAME.gpg add - && \
        echo $REPO_URL | sudo tee /etc/apt/sources.list.d/$NAME.list
    else
        echo $REPO_URL | sudo tee /etc/apt/sources.list.d/$NAME.list
    fi
}

# apt update
function apt_update_quiet() {
    sudo apt-get update > /dev/null
}

# apt install
function apt_install_quiet() {
    sudo apt-get install -y $@ > /dev/null
}

# apt update & install
function apt_update_install_quiet() {
    apt_update_quiet && apt_install_quiet
}

# OS packages
function install_os_packages() {
    OS_PACKAGES_PART_1="apt-transport-https bat ca-certificates curl fzf git gnupg-agent guake htop httpie jq nmap "
    OS_PACKAGES_PART_2="neofetch powerline software-properties-common stow terminator tree unzip vim wget xclip zip zsh"
    printf "${OS_PACKAGES_PART_1}\n"
    printf "${OS_PACKAGES_PART_2}\n"
    apt_update_quiet && apt_install_quiet ${OS_PACKAGES_PART_1} ${OS_PACKAGES_PART_2}
}

# Terminal
function setup_terminal() {
    log "Configure zsh as the default shell"
    chsh -s $(which zsh)
    log "Install oh-my-zsh addons"
    git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git 	${ZSH}/custom/plugins/zsh-syntax-highlighting
    git clone -q https://github.com/zsh-users/zsh-autosuggestions			${ZSH}/custom/plugins/zsh-autosuggestions
    git clone -q https://github.com/romkatv/powerlevel10k.git				${ZSH}/custom/themes/powerlevel10k
    stow --ignore='.gitkeep' zsh
}

# Docker
function install_docker() {
    log "Docker"
    add_deb_repo "docker" \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" \
            "https://download.docker.com/linux/ubuntu/gpg" && \
    apt_update_install_quiet docker-ce docker-ce-cli containerd.io
    COMPOSE_BIN="https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)"
    sudo curl -fsSL $COMPOSE_BIN -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose
    sudo groupadd docker
    sudo usermod -aG docker $USER
}

# Java
function install_java() {
    log "Sdkman"
    export SDKMAN_DIR="${XDG_CONFIG_HOME}/sdkman" && curl -s "https://get.sdkman.io" | bash > /dev/null
    source "${SDKMAN_DIR}/bin/sdkman-init.sh"
    log "Java"
    sdk install java 11.0.7.hs-adpt > /dev/null
    log "Gradle"
    sdk install gradle 5.5 > /dev/null
}

# Ansible
function install_ansible() {
    log "Ansible"
    sudo add-apt-repository --yes ppa:ansible/ansible > /dev/null && apt_update_install_quiet ansible
}

# Nodejs
function install_nodejs() {
    log "Nodejs & npm"
    nvm install v10.20.1
    npm config set prefix $NVM_DIR/versions/node/v10.20.1
    npm install -q -g vtop express-generator
}

# Brave
function install_brave() {
    log "Brave"
    add_deb_repo "brave-browser" \
            "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
            "https://brave-browser-apt-release.s3.brave.com/brave-core.asc" && \
    apt_update_install_quiet brave-browser
}

# Riot
function install_riot() {
    log "Riot"
    add_deb_repo "riot-desktop" \
            "deb https://packages.riot.im/debian/ default main" \
            "https://packages.riot.im/debian/riot-im-archive-keyring.gpg" && \
    apt_update_install_quiet riot-desktop
}

# Shutter
function install_shutter() {
    log "Shutter"
    sudo add-apt-repository --update --yes ppa:linuxuprising/shutter > /dev/null && \
    apt_install_quiet shutter
}

# Etcher
function install_etcher() {
    log "Etcher"
    sudo apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61 && \
    add_deb_repo "balena-etcher" "deb https://deb.etcher.io stable etcher" && \
    apt_update_install_quiet balena-etcher-electron
}

# Codium
function install_vscodium() {
    log "Codium"
    sudo snap install codium --classic
    stow --ignore='.gitkeep' vscodium
    for ext in $(grep -v '^#' vscodium/.config/VSCodium/User/extensions.list)
    do
        codium --extensions-dir ~/.config/VSCodium/User/extensions --install-extension $ext
        # echo $ext
    done
}

# Gitkraken
function install_gitkraken() {
    log "Gitkraken"
    sudo snap install gitkraken
}

# Postman
function install_postman() {
    log "Postman"
    sudo snap install postman
}

# Slack
function install_slack() {
    log "Slack"
    sudo snap install slack --classic
}

function main() {
    log_top_level "Install OS packages"
    install_os_packages

    log_top_level "Setup terminal"
    setup_terminal

    log_top_level "Install dev tools"
    install_docker
    install_java
    install_ansible
    install_nodejs

    log_top_level "Install desktop apps"
    install_brave
    install_riot
    install_shutter
    install_etcher
    install_vscodium
    install_gitkraken
    install_postman
    install_slack

    log_top_level "Populate dotfiles"
    stow --ignore='.gitkeep' fonts git nvm ssh terminator vim themes
    sudo fc-cache -f
    # stow zsh

    # git remote set-url origin git@github.com:zguesmi/dotfiles.git
    # sudo apt install gnome-tweak-tool
    # sudo apt install chrome-gnome-shell
    # install metamask
}

main
