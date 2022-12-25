#!/usr/bin/env bash
# remove.sh - Remove os arquivos baixados pelo script install.sh
# Version: 0.1
# License: MIT License
#

rm -rf $HOME/Linux-Login
cd $HOME
sed -i "s/bash.*login.sh//g" $HOME/.bash_login
echo -e "\e[32mTudo ok\e[0m"
sleep 1
