#!/bin/bash
# Cadastra um usuário
# 
# Por oliver
#

modo_uso="\t-h, --help\tShow this help screen and exit\n\t--setup\t\tConfigure user and password\n\t--undo\t\tUndo the configuration\n"

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
		register $user $password

	    else
		echo "Incorrect password"
		password
	    fi
	fi
    fi

}

# Registrar dados de acesso
register() {

    createDirectoryReq
    
    username=$1
    password=$2

    appendUser $username $password

    allowStorage
    
    if [[ -f $default_file ]] ; then
	cp $default_file .backup && rm $default_file
	apply

   else
	apply

    fi
}

# Cria diretórios necessários
createDirectoryReq() {
    if [[ -d user ]] ; then
	rm -rf user
	mkdir user
    fi

    if [[ ! -d user ]] ; then
	mkdir user
    fi

    if [[ ! -d .backup ]] ; then
	mkdir .backup
    fi
}

# Adicionar o usuário
appendUser() {
    username=$1
    password=$2

    cat ->> user/${username}.user <<- eof
user: $username
password: $password
eof

}

# Confirmar a configuração
apply() {
    if [[ -f .config ]] ; then
	rm .config
    fi

    echo "bash ~/Linux-Login/login.sh" > .config

    if [[ -f $backup_file ]] ; then
	cat $backup_file >> .config
	cp .config $default_file
    fi

    if [[ ! -f $backup_file ]] ; then
	cp .config $default_file
    fi

    echo "Registered $username user"
    echo "Backup in /sdcard/$username.user"
    echo "Stopping..."
    	
    sleep 2s
    pkill -KILL -u $(id -nu) &> /dev/null
}

# Permitir acesso ao armazenamento
allowStorage() {
    while [[ ! -d $HOME/storage ]] ; do
	echo
	read -p "Allow internal memory 'ENTER' to continue..." enter
	echo
	sleep ${deley}s
	termux-setup-storage
    done
}

# Fazer
setup() {
    
    if [[ -f .banner ]] ; then
	rm .banner
    fi

    python banner.py
    user
}

# Desfazer
undo() {
    echo "Enter to continue..." ; read
    restory_previous_file
    file_remove $backup_file
    
}

file_remove() {
    file=$1

    if [[ ! -f $file ]] ; then
	echo -e "\e[0mRemoving $file...\e[31;1mNot exists\e[0m"

    else

        rm $file &> /dev/null

	if [[ ! -f $file ]] ; then
            echo -e "\e[0mRemoving $file...\e[32;1mOK\e[0m"

	else
	    echo -e "\e[0mRemoving $file...\e[31;1mFailed\e[0m"

	fi

    fi
}

restory_previous_file() {
    if [[ -f $backup_file ]] ; then
	cat $backup_file > $default_file

	if [ -f $default_file -a ! -f $backup_file ] || [ -f $default_file -a -f $backup_file ]; then
	    echo -e "\e[0mRestoring previous file...\e[32;1mOK\e[0m"

        else
	    echo -e "\e[0mRestoring previous file...\e[31;1mFailed\e[0m"
	fi

    else
	echo -e "\e[0mRestoring previous file...\e[31;1mNot exists\e[0m"
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
			echo "Try -h | --help"
			exit;;

	esac
	shift
done
