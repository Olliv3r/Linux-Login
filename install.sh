#!/usr/bin/env bash
# instalador externo
# 
# Por oliver
#
#

install() {
    pkg upgrade -y && apt install ncurses-utils -y
    apt install neofetch python git -y
}

clone() {
    [[ -d ~/Linux-Login ]] && rm -rf ~/Linux-Login
    cd ~
    git clone https://github.com/Olliv3r/Linux-Login
}

show_use() {
    local root="~/Linux-Login"

    echo -e "\n\e[0m\e[32;2mRun '\e[33;1mbash ./setup.sh setup\e[0m\e[32;2m' to configure \nOR '\e[33;1mbash ./setup.sh undo\e[0m\e[32;2m' to undo\e[0m"
    cd .. && cd $root
}

clear
install
clone
show_use
