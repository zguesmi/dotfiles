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

    if [ ! -z ${GPG_URL} ]; then
        curl -fsSL ${GPG_URL} | sudo gpg --dearmor -o /etc/apt/keyrings/${NAME}.gpg && \
        echo ${REPO_URL} | sudo tee /etc/apt/sources.list.d/${NAME}.list
    else
        echo ${REPO_URL} | sudo tee /etc/apt/sources.list.d/${NAME}.list
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
    #gnome-shell-pomodoro
    printf "${OS_PACKAGES_PART_1}\n"
    printf "${OS_PACKAGES_PART_2}\n"
    apt_update_quiet && apt_install_quiet ${OS_PACKAGES_PART_1} ${OS_PACKAGES_PART_2}
}

function install_additional_tools() {
    sudo apt install -o Dpkg::Options::="--force-overwrite" ripgrep
    sudo snap install procs # htop
    sudo apt install exa # ls
    # https://github.com/Peltoche/lsd#installation
    # https://github.com/dandavison/delta#installation
    sudo snap install duf-utility
    sudo apt-get install fd-find
    ln -s $(which fdfind) ~/.local/bin/fd
    # https://github.com/rs/curlie
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
    NAME="docker"
    add_deb_repo "${NAME}" \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/${NAME}.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" \
            "https://download.docker.com/linux/ubuntu/gpg" && \
    apt_update_install_quiet docker-ce docker-ce-cli containerd.io docker-compose-plugin
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
#function install_ansible() {
#    log "Ansible"
#    sudo add-apt-repository --yes ppa:ansible/ansible > /dev/null && apt_update_install_quiet ansible
#}

# Nodejs
function install_nodejs() {
    # This works in a ZSH shell.
    log "Nodejs & npm"
    nvm install stable
}

# Brave
function install_brave() {
    log "Brave"
    NAME="brave-browser"
    add_deb_repo "${NAME}" \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/${NAME}.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
            "https://brave-browser-apt-release.s3.brave.com/brave-core.asc" && \
    apt_update_install_quiet brave-browser
}

# Element
#function install_element() {
#    log "Element"
#    add_deb_repo "element-desktop" \
#            "deb https://packages.riot.im/debian/ default main" \
#            "https://packages.riot.im/debian/riot-im-archive-keyring.gpg" && \
#    apt_update_install_quiet riot-desktop
#}

# Shutter
#function install_shutter() {
#    log "Shutter"
#    sudo add-apt-repository --update --yes ppa:linuxuprising/shutter > /dev/null && \
#    apt_install_quiet shutter
#}

# Etcher
#function install_etcher() {
#    log "Etcher"
#    sudo apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61 && \
#    add_deb_repo "balena-etcher" "deb https://deb.etcher.io stable etcher" && \
#    apt_update_install_quiet balena-etcher-electron
#}

# Codium
function install_vscodium() {
    log "Codium"
    sudo snap install codium --classic
    stow --ignore='.gitkeep' vscodium
    for ext in $(grep -v '^#' vscodium/.config/VSCodium/User/extensions.list)
    do
        # echo $ext
        codium --extensions-dir ~/.config/VSCodium/User/extensions --install-extension $ext
    done
}

# Gitkraken
#function install_gitkraken() {
#    log "Gitkraken"
#    sudo snap install gitkraken
#}

# Postman
function install_postman() {
    log "Postman"
    sudo snap install postman
}

# Slack
function install_slack() {
    log "Slack"
    sudo snap install slack
}

function main() {
    log_top_level "Install OS packages"
    install_os_packages

    log_top_level "Setup terminal"
    setup_terminal

    log_top_level "Install dev tools"
    install_docker
    install_java
    install_nodejs
    #install_ansible

    log_top_level "Install desktop apps"
    install_brave
    install_vscodium
    install_postman
    install_slack
    #install_element
    #install_shutter
    # install_etcher
    #install_gitkraken

    log_top_level "Populate dotfiles"
    stow --ignore='.gitkeep' fonts git nvm ssh terminator vim themes
    sudo fc-cache -f
    # stow zsh

    # git remote set-url origin git@github.com:zguesmi/dotfiles.git
    # sudo apt install gnome-tweak-tool
    # sudo apt install chrome-gnome-shell
}

main
