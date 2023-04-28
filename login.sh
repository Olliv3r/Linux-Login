#!/usr/bin/env bash
# Login simples do linux termux android
#
# Autor, Oliver
#
# 

# Login padrão (pode alterar)

username='root'
password='toor'
mask="×"


control() {
    stty echoctl
    unset input
    unset usernameInput
    unset passwordInput
}

input() {

    trap control SIGINT SIGTSTP

    scape=$(printf '\u1b')
    u=1
    p=0

    while [[ true ]] ; do

	echo -ne "\rUser Name: $input"

	if [[ $p == 1 ]] ; then
	    echo -ne "\rPass Word: $inputMask"

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
		    echo -e "\n\e[0m\e[31;1mInvalid user\e[0m"
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
		    echo -e "\n\e[0m\e[31;1mInvalid password\e[0m"

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
    clear
    neofetch --ascii_distro Kali -L
    echo -e "Novo login\n"
}

main() {
    if [ -f /data/data/com.termux/files/usr/tmp/.logged ] ; then
	clear
	neofetch --ascii_distro Kali -L
	echo -e "Nova aba\n"

    else
	input

    fi
}

main
