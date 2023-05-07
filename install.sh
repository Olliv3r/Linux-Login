#!/usr/bin/env bash
# instalador externo
# 
# Por oliver
#
#

clear
pkg upgrade -y && apt install ncurses-utils -y

anim() {
    local pid=$!
    local chars=("." ".." "..." "....")
    local delay=0.5


    while [ $(ps a | awk '{printf $1}' | grep $pid) ] ; do
	for char in ${chars[*]} ; do
	    tput civis
	    printf "\e[0m\e[32;2m\r[*] $1${char}\e[0m"
	    sleep ${delay}s
	    printf "\b\b\b\b\b\b\b\b"
	done
    done

    printf "\b\b\b\b"
    printf "\e[0m\e[32;2m\r[+] $1....OK\e[0m\n"
    tput cnorm


}
install() {
    apt install neofetch python git -y &> /dev/null
}

clonn() {
    [[ -d ~/Linux-Login ]] && rm ~/Linux-Login

    apt install net-tools -y &> /dev/null
    cd ~
    git clone https://github.com/Olliv3r/Linux-Login &> /dev/null
}

show_use() {
    local root="~/Linux-Login"

    echo -e "\n\e[0m\e[32;2mRun '\e[33;1mbash $root/setup.sh setup\e[0m\e[32;2m' to configure \nOR '\e[33;1mbash $root/setup.sh undo\e[0m\e[32;2m' to undo\e[0m"
    cd ~/Linux-Login
}

install & anim "Installing packages"
clonn & anim "Cloning repository"
show_use
