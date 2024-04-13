#!/bin/bash

# TODO - check if ran with sudo ?

downloaddir=~/"Downloads/discord"
install_path=$HOME/.local/share

# Function to prompt for user confirmation
confirm() {
    read -r -p "$1 [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
        ;;
        *)
            false
        ;;
    esac
}


if confirm "Do you want to remove all previous Discord installs? It is recommended when updating/installing anew"; then
    sudo apt remove discord -y
    sudo dnf remove discord -y
    sudo snap remove discord
    rm -rf $install_path/Discord
fi



# INSTALLING NEW VERSION MANUALLY

# download latest version
echo "Downloading latest version..."
mkdir -p $downloaddir
cd $downloaddir
wget -O discord.tar.gz "https://discord.com/api/download?platform=linux&format=tar.gz"
tar -xvf discord.tar.gz


mkdir -p $HOME/.local/share/Discord
mkdir -p $HOME/.local/share/applications
cp -R Discord $install_path
cat << EOF > $HOME/.local/share/applications/discord.desktop
[Desktop Entry]
Name=Discord
Exec=$HOME/.local/share/Discord/Discord
Icon=$HOME/.local/share/Discord/discord.png
Type=Application
Path=$HOME/.local/share/Discord
EOF
