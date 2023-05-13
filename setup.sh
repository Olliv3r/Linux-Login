#!/bin/bash
# Configura um usuário personalizado
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

    cat ->> $root/user/${username}.user.txt <<- eof
username: $username
password: $password
eof

    allowStorage
    get_backup_file
    apply
}

# Criar diretórios necessários

createDirectoryReq() {
    [[ -d $root/user ]] && rm -rf $root/user && mkdir $root/user
    [[ ! -d $root/user ]] && mkdir $root/user
    [[ ! -d $root/.backup ]] && mkdir $root/.backup
}

# Permitir o acesso a memoria

allowStorage() {
    while [[ ! -d $HOME/storage ]] ; do
	echo
	read -p "Allow internal memory 'ENTER'..."
	termux-setup-storage

	read -p "Confirm memory permission by pressing 'ENTER'..."
    done

    cp $root/user/*.txt /sdcard
}

# Fazer o backup

get_backup_file() {
    if [[ -f $default_file ]] ; then
	str=$(grep -Eo "bash.*login\.sh" $default_file)

	if [[ -n "$str" ]] ; then
	    sed -i "/bash.*login\.sh/d" $default_file
	    cat $default_file > $backup_file

	    if [[ -f $backup_file ]] ; then
		echo "Backup done successfully"

            else
		echo "Couldn't make backup"
	    fi

	else
	    cat $default_file > $backup_file
	fi

    else
	echo "No file for backup"
    fi
}


# Aplicar a configuração

apply() {
    [[ -f $root/.config ]] && rm $root/.config

    echo "bash ~/Linux-Login/login.sh" > $root/.config

    if [[ -f $backup_file ]] ; then
	cat $backup_file >> $root/.config
    fi

    cat $root/.config > $default_file

    echo "Registered $username user"
    echo "Backup in /sdcard/$username.user.txt"
    echo "Stopping..."

    sleep 2s
    pkill -KILL -u $(id -nu) &> /dev/null
}

# Fazer

setup() {
    [[ -f $root/.banner ]] && rm $root/.banner
    python $root/banner.py
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

    if [[ -f $default_file ]] ; then
	str=$(grep -Eo "bash.*login\.sh" $default_file)

	if [[ -n "$str" ]] ; then
	    file_remove $default_file
	fi
    fi

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

# Remove arquivo ou diretório

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

# Verifica argumentos

[[ -z "$1" ]] && echo "Error: try $0 -h | --help | help to help" && exit

# Trata os argumentos e opçôes

while [[ -n "$1" ]] ; do
    case "$1" in
	help|-h|--help)
	    echo -e "$modo_uso";;
	setup|-s|--setup)
	    setup;;
	undo|-u|--undo)
	    undo;;
	*)
	    echo "Error: try $0 -h, --help, help to help"
	    exit;;
    esac
    shift
done
