
#!/bin/bash
# Cadastra um usuário
# 
# Por oliver
#

if [[ -f .banner ]] ; then
    rm .banner
fi

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

    if [[ ! -d ~/storage ]] ; then

        echo "Allow memory storage"
	sleep 3s
	cp user/*.user /sdcard

    else
        cp user/*.user /sdcard
    fi

    echo "User registed"
    echo "Backup in /sdcard/$user.user"
}

python banner.py

user
