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

function apt_update_install_quiet() {
    sudo apt-get update > /dev/null && \
            sudo apt-get install -y $@ #> /dev/null
}

function install_os_packages() {
    OS_PACKAGES_PART_1="apt-transport-https bat ca-certificates chrome-gnome-shell curl fzf git gnupg-agent guake htop httpie jq nmap "
    OS_PACKAGES_PART_2="neofetch powerline shutter software-properties-common stow terminator tree unzip vim wget xclip zip zsh"
    #gnome-shell-pomodoro
    printf "${OS_PACKAGES_PART_1}\n"
    printf "${OS_PACKAGES_PART_2}\n"
    apt_update_install_quiet ${OS_PACKAGES_PART_1} ${OS_PACKAGES_PART_2}
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

function setup_terminal() {
    log "Configure zsh as the default shell"
    chsh -s $(which zsh)
    log "Install oh-my-zsh addons"
    git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git 	${ZSH}/custom/plugins/zsh-syntax-highlighting
    git clone -q https://github.com/zsh-users/zsh-autosuggestions			${ZSH}/custom/plugins/zsh-autosuggestions
    git clone -q https://github.com/romkatv/powerlevel10k.git				${ZSH}/custom/themes/powerlevel10k
    stow --ignore='.gitkeep' zsh # Needed for the rest of the setup.
}

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

function install_java() {
    log "Sdkman"
    export SDKMAN_DIR="${XDG_CONFIG_HOME}/sdkman" && curl -s "https://get.sdkman.io" | bash > /dev/null
    source "${SDKMAN_DIR}/bin/sdkman-init.sh"
    log "Java"
    sdk install java 11.0.7.hs-adpt > /dev/null
    log "Gradle"
    sdk install gradle 5.5 > /dev/null
}

function install_nodejs() {
    # This works in a ZSH shell.
    log "Nodejs & npm"
    nvm install stable
}

function install_brave() {
    log "Brave"
    NAME="brave-browser"
    add_deb_repo "${NAME}" \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/${NAME}.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
            "https://brave-browser-apt-release.s3.brave.com/brave-core.asc" && \
    apt_update_install_quiet brave-browser
}

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

function install_postman() {
    log "Postman"
    sudo snap install postman
}

function install_slack() {
    log "Slack"
    sudo snap install slack
}

function install_bitwarden() {
    log "Bitwarden"
    sudo snap install bitwarden
}

function display_manual_setup() {
    echo "Install Brave extensions:"
    echo "Onetab https://chromewebstore.google.com/detail/onetab/chphlpgkkbolifaimnlloiipkdnihall"
    echo "Bitwarden https://chromewebstore.google.com/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb"
    echo "Vimium https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb"
    echo "Gnome https://chromewebstore.google.com/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep"
    echo "Night theme https://extensions.gnome.org/extension/2236/night-theme-switcher/"
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

    log_top_level "Install desktop apps"
    install_brave
    install_vscodium
    install_postman
    install_slack
    install_bitwarden

    log_top_level "Manual setup"
    display_manual_setup

    log_top_level "Populate dotfiles"
    stow --ignore='.gitkeep' autostart fonts git nvm ssh themes terminator vim
    sudo fc-cache -f

    git remote set-url origin git@github.com:zguesmi/dotfiles.git
    # sudo apt install gnome-tweak-tool
    # sudo apt install chrome-gnome-shell
}

main
