#!/usr/bin/env bash
# install.sh - Instala pacotes requisitados pelo script login.sh
# Version: 0.1
# Author: Oliver
# License: MIT License

echo -e "\e[32mInstalando...\e[0m"
pkg update -y #> /dev/null 2>&1
pkg upgrade -y #> /dev/null 2>&1
pkg install ncurses-utils git -y > /dev/null 2>&1
git clone https://github.com/Olliv3r/Linux-Login > /dev/null 2>&1

echo -e "\e[32mConfigurando...\e[0m"
echo 'bash $HOME/Linux-Login/login.sh' >> $HOME/.bash_login
echo -e "\e[32mReinicie seu termux\e[0m"
