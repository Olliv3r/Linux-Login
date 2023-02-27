#!/usr/bin/env bash
#
#

# Variáveis resetadas
unset username
unset password
unset mask
unset caracter
unset key_user
unset key_password

# Acesso padrão
username_default="root" # Pode alterar
password_default="toor" # Pode alterar
mask='∗'                # Pode alterar
caracter=''

# Textos de uso das funçôes
msg=("Username" "Password" "Invalid user" "Invalid password" "Forbidden keys" "Logged in as" "New window"
)
alertUser() {
    printf "\r${msg[4]}!\n" && printf "\r${msg[0]}: "
    unset username && unset caracter
}
alertPassword() {
    printf "\r${msg[4]}!\n" && printf "\r${msg[1]}: "
    unset password && unset caracter
}
trapp() {
  [ -n "$username" -o -z "$username" -a "$1" == "username" ] && trap alertUser SIGINT SIGTSTP
  [ -n "$password" -o -z "$password" -a "$1" == "password" ] && trap alertPassword SIGINT
}
# Backspace
backspace() {
  [ -n "$1" -a -n "$2" -a "$2" == "caracter" ] && caracter=${caracter%?}
  [ -n "$1" -a -n "$2" -a "$2" == "username" ] && username=${username%?} && printf "\b \b"
  [ -n "$1" -a -n "$2" -a "$2" == "password" ] && password=${password%?} && printf "\b \b"
}
# Entrada de usuário
inputUser() {
  trapp "username"
  
  printf "\r${msg[0]}: "
  while IFS= read -r -s -n1 input_username ; do
    if [ -z "$input_username" ] ; then
	    printf "\r${msg[2]}!\n"
	    printf "\r${msg[0]}: "

	    unset username
	    unset password

    elif [ "$input_username" == $'\x7f' ] ; then
      backspace $caracter "caracter"
      backspace $username "username"

    elif [ "$input_username" == $'\x1B' ] || [ "$input_username" == $'\x09' ] || [ "$input_username" == $'\x20' ] ; then
      printf "\r${msg[4]}!\n"
      printf "\r${msg[0]}: "

      unset username
      unset caracter

  	else
      username+=$input_username
      caracter+=$input_username

      echo -ne "$caracter"

      if [ "$username" == "$username_default" ] ; then
        key_user=$username
        break
      fi

  	  unset caracter
  	fi
  done
}
# Entrada de senha
inputPassword() {
  trapp "password"

  printf "\n"
  printf "\r${msg[1]}: "
  while IFS= read -r -s -n1 input_password ; do
    if [ -z "$input_password" ] ; then
      printf "\r${msg[3]}\n"
      printf "\r${msg[1]}: "

      unset password
      unset caracter

    elif [ "$input_password" == $'\x7f' ] ; then
      backspace $caracter "caracter"
      backspace $password "password"

    elif [ "$input_password" == $'\x1B' ] ||
    [ "$input_password" == $'\x09' ] ||
    [ "$input_password" == $'\x20' ] ; then
      printf "\r${msg[4]}!\n"
      printf "\r${msg[1]}: "

      unset password
      unset caracter

    else
      password+=$input_password
      caracter+=$input_password

      echo -ne "$mask"

      if [ "$password" == "$password_default" ] ; then
        key_password=$password
        break
      fi

      unset caracter
    fi
  done
}
# Verifica entrada de usuário e senha
verify() {
  if [ "$key_user" == "$username_default" -a "$key_password" == "$password_default" ] ; then
    start
  fi
}
# Mensagen de logado
start() {
  echo "export LINUX_LOGIN=true" > /data/data/com.termux/files/usr/tmp/.logged
  reset
  clear
  echo -e "Logado\n"
}
# Função principal
main() {
  if [ -f /data/data/com.termux/files/usr/tmp/.logged ] ; then
    echo -e "\n${msg[6]}"
    exit 0
  else
    inputUser
    inputPassword
    verify
  fi
}
# Invocar função principal
main