#!/bin/bash


PACKAGES="apt-transport-https ca-certificates curl git gnupg-agent htop"
PACKAGES+="httpie jq nmap software-properties-common stow tree vim wget zsh"
printf "> Installing the following packages:\n$PACKAGES\n"
sudo apt-get update > /dev/null && sudo apt-get install -y $PACKAGES > /dev/null

# ZSH
printf "> Configuring zsh as the default shell for user: $USER\n"
chsh -s $(which zsh)
printf "> Installing custom oh-my-zsh addons\n"
# TODO: add those as submodules
git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git 	zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone -q https://github.com/zsh-users/zsh-autosuggestions			zsh/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone -q https://github.com/Powerlevel9k/powerlevel9k.git 			zsh/.oh-my-zsh/custom/themes/powerlevel9k
git clone -q https://github.com/romkatv/powerlevel10k.git				zsh/.oh-my-zsh/custom/themes/powerlevel10k

# Desktop apps
sudo snap install codium docker gitkraken node postman slack --classic

# Brave
printf "> Installing Brave browser\n"
sudo apt install apt-transport-https curl
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt-get update > /dev/null && sudo apt install -y brave-browser > /dev/null

# Riot
printf "> Installing Brave browser\n"
sudo curl -s https://packages.riot.im/debian/riot-im-archive-keyring.gpg | sudo apt-key --keyring /etc/apt/trusted.gpg.d/riot-im.gpg add -
echo "deb https://packages.riot.im/debian/ default main" | sudo tee /etc/apt/sources.list.d/riot-im.list
sudo apt-get update > /dev/null && sudo apt install -y riot-desktop > /dev/null

# Shutter

# dotfiles
stow vscodium zsh
