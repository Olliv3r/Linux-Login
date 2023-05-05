
#!/bin/bash
# Cadastra um usuário
# 
# Por oliver
#

modo_uso="\t-h, --help\tShow this help screen and exit\n\t--setup\t\tConfigure user and password\n\t--undo\t\tUndo the configuration\n"

user() {
    read -p "New user: " user

    if [[ -z $user ]] ; then
	echo "Invalid input user"
	user

    else
	password
    fi
}

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

register() {
    if [[ -d user ]] ; then
        rm -rf user
	mkdir user
	
    else
	mkdir user
    fi

    user=$1
    password=$2

    cat ->> ./user/${user}.user <<- eof
user: $user
password: $password
eof

    allowAccessMemoryStorage

    [[ -f ~/.bash_login ]] && cp ~/.bash_login .backup && rm ~/.bash_login

    echo "bash ~/Linux-Login/login.sh" > .config
    cat .backup/.bash_login >> .config
    cp .config ~/.bash_login

    echo "User registed"
    echo "Backup in /sdcard/$user.user"
    echo "Saindo..."
    sleep 2s
    pkill -KILL -u $(id -nu) &> /dev/null
}

allowAccessMemoryStorage() {
    if [[ ! -d ~/storage ]] ; then
        echo "Allow memory storage"
        sleep 2s
	termux-setup-storage

    else
	cp user/*.user /sdcard
    fi
}

setup() {
    
    if [[ -f .banner ]] ; then
	rm .banner
    fi

    python banner.py
    user
}

undo() {
    echo "Enter to continue" ; read

    if [[ -f .backup/.bash_login ]] ; then
        rm ~/.bash_login &> /dev/null
        echo "Restoring previous backup..."
        cp .backup/.bash_login ~/.bash_login &> /dev/null
	rm .backup/.bash_login
    else
	echo "No backup"
	exit
    fi
}

[[ -z "$1" ]] && echo "Try -h | --help" && exit

while [[ -n "$1" ]] ; do
	case "$1" in
		-h|--help)
			echo -e "$modo_uso";;
		--setup)
			setup;;
		--undo)
			undo;;
		*)
			echo "Try -h | --help"
			exit;;

	esac
	shift
done
