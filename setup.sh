#!/bin/bash


export XDG_CONFIG_HOME="$HOME/.config"
# export XDG_CACHE_HOME="$HOME/.cache"
export ZSH="${XDG_CONFIG_HOME}/ohmyzsh"

LOG_FILE=install.log

GR="\033[1;32m" # green
YE="\033[1;33m" # yellow
BL="\033[1;34m" # blue
NC="\033[0m"    # no color

function log_top_level() {
    printf "\n${YE}-> ${1}${NC}\n"
}

function log() {
    printf "${GR}  -> ${1}${NC}\n"
}

function apt_update_install_quiet() {
    sudo apt update >> ${LOG_FILE} && \
        sudo apt install -y $@ >> ${LOG_FILE}
}

function install_tools() {
    PACKAGES="
        bat
        chrome-gnome-shell
        curl
        duf-utility
        exa
        fd-find
        fzf
        git
        guake
        htop
        httpie
        jq
        pdfarranger
        powerline
        ripgrep
        stow
        terminator""
        tree
        unzip
        vim
        wget
        xclip
        zip
        zsh
    "
    # software-properties-common
    # gnupg-agent
    # gnome-tweak-tool
    # chrome-gnome-shell
    # https://github.com/Peltoche/lsd#installation
    # https://github.com/rs/curlie

    printf "${PACKAGES}\n"
    apt_update_install_quiet ${PACKAGES}
    ln -s $(which fdfind) ~/.local/bin/fd
}

function install_ohmyzsh() {
    log "Configure ZSH as the default shell"
    chsh -s $(which zsh)
    log "Install ohmyzsh + plugins"
    git clone https://github.com/ohmyzsh/ohmyzsh.git ${ZSH}
    git clone --depth=1 -q https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH}/custom/plugins/zsh-syntax-highlighting
    git clone --depth=1 -q https://github.com/zsh-users/zsh-autosuggestions ${ZSH}/custom/plugins/zsh-autosuggestions
    git clone --depth=1 -q https://github.com/romkatv/powerlevel10k.git ${ZSH}/custom/themes/powerlevel10k
    stow --ignore='.gitkeep' zsh # Needed for the rest of the setup.
}

function install_devtools() {
    log "NVM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | zsh
    # This works in a ZSH shell.
    log "Nodejs & npm"
    nvm install stable
    log "VSCode"
    sudo snap install code --classic
    log "Docker"
    curl -fsSL https://get.docker.com | sh
    sudo groupadd docker
    sudo usermod -aG docker $USER
    docker run hello-world
}

function install_apps() {
    log "Brave"
    curl -fsS https://dl.brave.com/install.sh | sh
    log "Slack"
    sudo snap install slack
    log "Bitwarden"
    sudo snap install bitwarden
}

function print_post_install_instructions() {
    echo "Install Brave extensions:"
    echo "Onetab https://chromewebstore.google.com/detail/onetab/chphlpgkkbolifaimnlloiipkdnihall"
    echo "Bitwarden https://chromewebstore.google.com/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb"
    echo "Vimium https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb"
    echo "Gnome https://chromewebstore.google.com/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep"
    echo "Night theme https://extensions.gnome.org/extension/2236/night-theme-switcher/"
}

function main() {
    echo "Log file: ${LOG_FILE}"

    log_top_level "Install OS packages"
    install_tools

    log_top_level "Setup terminal"
    install_ohmyzsh

    log_top_level "Install dev tools"
    install_devtools

    log_top_level "Install desktop apps"
    install_apps

    log_top_level "Populate dotfiles"
    stow --ignore='.gitkeep' autostart fonts git nvm ssh themes terminator vim
    fc-cache -f -v # Update fonts.

    log_top_level "Post install instructions"
    print_post_install_instructions

    # Use SSH connection.
    git remote set-url origin git@github.com:zguesmi/dotfiles.git
}

main

# If the camera isn't working, possible fixes:
# `sudo usermod -aG video $USER`
# `systemctl --user restart pipewire`
