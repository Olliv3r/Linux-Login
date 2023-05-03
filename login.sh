#!/usr/bin/env bash
# Login simples do linux termux android
#
# Autor, Oliver
#
# 

clear

# Login padrão (pode alterar)

username='root'
password='toor'
mask="×"


control() {
    stty echoctl
    unset usernameInput
    unset passwordInput
    echo -e "\n\n\e[0m\e[31;1;7mMatando sessão por questão de segurança...\e[0m"
    pkill -KILL -u $(id -nu) &> /dev/null
}

input() {

    trap control SIGINT SIGTSTP

    scape=$(printf '\u1b')
    u=1
    p=0

    neofetch --ascii_distro Kali -L
    while [[ true ]] ; do

	echo -ne "\r\e[0m\e[33;1mUser Name:\e[0m $input\e[0m"

	if [[ $p == 1 ]] ; then
	    echo -ne "\r\e[0m\e[33;1mPass Word:\e[0m $inputMask\e[0m"

	fi

	IFS= read -rsn1 mode

	if [[ $mode == $scape ]] ; then

	    IFS= read -rsn2 mode

	    case $mode in
		*)
	    esac

	elif [[ $mode == $'\x7f' ]] ; then
	    if [[ -n $input ]] ; then
	        input=${input%?}
		inputMask=${inputMask%?}
	        printf "\b \b"
		
	    fi

	elif [[ $mode == $'\0A' ]] ; then

	    if [[ -n $input ]] && [[ $u == 1 ]] && [[ $p == 0 ]] ; then
		usernameInput=$input
	        unset input
		unset inputMask

		if [[ $usernameInput == $username ]] ; then
		    echo
		    unset usernameInput
		    p=1

		else
		    echo -e "\n\e[0m\e[31;3mInvalid user\e[0m"
		fi

	    elif [[ -n $input ]] && [[ $u == 1 ]] && [[ $p == 1 ]] ; then
		passwordInput=$input
		unset input
		unset inputMask

		if [[ $passwordInput == $password ]] ; then
		    echo
		    unset passwordInput
		    session
		    break

		else
		    echo -e "\n\e[0m\e[31;3mInvalid password\e[0m"

		fi

	    fi

	else
	    input+=$mode
	    inputMask+="$mask"

	fi

    done
}

session() {
    echo "export LINUX_LOGIN=true" > /data/data/com.termux/files/usr/tmp/.logged
    banner
    echo -e "Novo login\n"
}

banner() {
	clear
	neofetch --ascii_distro kali -L
}

main() {
    if [ -f /data/data/com.termux/files/usr/tmp/.logged ] ; then
	banner
	echo -e "Nova aba\n"

    else
	input

    fi
}
	
main
