#!/bin/bash
# Cadastra um usuário
# 
# Por oliver
#

modo_uso="\t-h, --help, help\tShow this help screen and exit\n\t-s, --setup, setup\tConfigure user and password\n\t-u, --undo, setup\tUndo the configuration\n"

root=$HOME/Linux-Login
default_file=$HOME/.bash_login
backup_file=$root/.backup/.bash_login
delay=0.2

# Entrada de nome de usuário
user() {

    read -p "New user: " user

    if [[ -z $user ]] ; then
	echo "Invalid input user"
	user

    else
	password
    fi

}

# Entrada de senha
password() {
    
    read -p "New password: " password

    if [[ -z $password ]] ; then
	echo "Invalid input password"
	password

    else
	read -p "Re-new password: " re_password

	if [[ -z $re_password ]] ; then
	    echo "Invalid input password"
	    password

        else
	    if [[ $password == $re_password ]] ; then
		appendUser $user $password

	    else
		echo "Incorrect password"
		password
	    fi
	fi
    fi

}

# Adicionar o login

appendUser() {
    createDirectoryReq

    username=$1
    password=$2

    cat ->> user/${username}.user <<- eof
username: $username
password: $password
eof

    allowStorage
    get_backup_file
    apply
}

# Cria diretórios necessários

createDirectoryReq() {
    [[ -d user ]] && rm -rf user && mkdir user
    [[ ! -d user ]] && mkdir user
    [[ ! -d .backup ]] && mkdir .backup
}

# Permite o acesso a memoria

allowStorage() {
    while [[ ! -d $HOME/storage ]] ; do
	echo
	read -p "Allow internal memory 'ENTER' to continue..." enter
	echo
	sleep ${delay}s
	termux-setup-storage
done
}

# Fazer o backup
get_backup_file() {
    if [[ -f $default_file ]] ; then
	cat $default_file > $backup_file

	if [[ -f $backup_file ]] ; then
	    echo "Backup done successfully"

        else
	    echo "Couldn't make backup"
	fi

    else
	echo "No file for backup"
	echo "" > $backup_file
    fi
}


# Aplica a configuração

apply() {
    [[ -f $root/.config ]] && rm $root/.config

    echo "bash ~/Linux-Login/login.sh" > $root/.config

    if [[ -f $backup_file ]] ; then
	cat $backup_file >> $root/.config
    fi

    cat $root/.config > $default_file
    
    echo "Registered $username user"
    echo "Backup in /sdcard/$username.user"
    echo "Stopping..."
    	
    sleep 2s
    pkill -KILL -u $(id -nu) &> /dev/null
}

# Fazer

setup() {
    [[ -f .banner ]] && rm .banner
    python banner.py
    user
}

# Desfazer

undo() {
    echo -n "Enter to continue..." ; read
    restory_previous_file
    
    echo -e "\e[0mRemoving files...\e[0m"
    for f in "$root/user/" "$root/.backup/" "$root/distros.txt" "$root/.banner" "$root/.config"; do
	file_remove $f
    done
    
}

# Restaurar o backup

restory_previous_file() {
    if [[ -f $backup_file ]] ; then
	cat $backup_file > $default_file

	if [[ -f $default_file ]] ; then
	    echo "Backup Restored Successfully"
	
        else
	    echo "Could not restore backup"
	fi

    else
	echo "No backup found"
    fi
}

file_remove() {
    file=$1

    if [[ -f $file ]] || [[ -d $file ]] ; then
	rm $file -rf &> /dev/null

	if [[ ! -f $file ]] || [[ ! -d $file ]] ; then
	    echo -e "\e[0mRemoving $(basename "$file"): \e[32;1mOK\e[0m"

	else
	    echo -e "\e[0mRemoving $(basename "$file"): \e[31;1mFailed\e[0m"
	fi

    else
	echo -e "\e[0mRemoving $(basename "$file"): \e[31;1mNot found\e[0m"
    fi
}

[[ -z "$1" ]] && echo "Try -h | --help" && exit

while [[ -n "$1" ]] ; do
	case "$1" in
		help|-h|--help)
			echo -e "$modo_uso";;
		setup|-s|--setup)
			setup;;
		undo|-u|--undo)
			undo;;
		*)
			echo "Error: try $0 -h, --help, help"
			exit;;

	esac
	shift
done
