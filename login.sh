#!/usr/bin/env bash
# login.sh
#
# 

unset usuario
unset senha

# Chaves de ativação das funcionalidades
chave_usuario=0
chave_senha=0

# Variáveis login padrão (Pode alterar)
username="root"
password="toor"

# Mascara ou usuário ov senha
caractere=''

message_interrupt() {
	unset usuario
	unset senha
	tput setaf 1
	echo -e "\e[1;5;40m=> \e[0;5;41mAtalho proíbido!\e[0m"
	tput sgr0
	echo -ne "\e[0;5;44m$texto_adm:\e[0m "
}

texto_adm="Usuário"
trap message_interrupt SIGINT SIGTSTP

echo -e "Painel adm Termux ***\n"

printf "\r\e[0;5;44mUsuário:\e[0m "

while IFS= read -r -s -n1 mascara_usuario; do
	texto_adm="Usuário"

	if [[ -z $mascara_usuario ]] ; then
		tput setaf 1
		echo -e "\e[1;5;40m => \e[0;5;41mUsuário inválido!\e[0m"
		tput sgr0
		printf "\r\e[0;5;44m$texto_adm:\e[0m "

		unset usuario
		unset caractere

	# Backspace (Remove o último caractere)
	elif [[ $mascara_usuario == $'\x7f' ]] ; then

		if [[ -n $caractere ]] ; then
			caractere=${caractere%?}
		fi

		if [[ -n $usuario ]] ; then
			usuario=${usuario%?}
			printf "\b \b"
		fi
	
	# Bloqueia teclas ESC, TAB e ESPAÇO
	elif [[ $mascara_usuario == $'\x1B' ]] || 
	     [[ $mascara_usuario == $'\x09' ]] ||
	     [[ $mascara_usuario == $'\x20' ]] ; then
		tput setaf 1
		echo -e "\e[1;5;40m => \e[0;5;41mTacla proíbida!\e[0m"
		tput sgr0
		printf "\r\e[0;5;44m$texto_adm:\e[0m "
		unset usuario
		unset caractere

	else
		usuario+=$mascara_usuario
		caractere+=$mascara_usuario

		# Mascara ou caractere (pode alterar)
		echo -ne "\e[32;5m$caractere\e[0m"

		if [[ $usuario == $username ]] ; then
			chave_usuario=1
			break
		fi

		unset caractere
	fi
done

echo

texto_adm="Senha"
unset caractere
trap message_interrupt SIGINT SIGTSTP

printf "\r\e[0;5;44m$texto_adm:\e[0m "

while IFS= read -r -s -n1 mascara_senha; do
	texto_adm="Senha"

	if [[ -z $mascara_senha ]] ; then
		tput setaf 1
		echo -e "\e[1;5;40m => \e[0;5;41mSenha inválida!\e[0m"
		tput sgr0
		printf "\r\e[0;5;44m$texto_adm:\e[0m "
		unset senha
		unset caractere

	# Backspace (Remove o último caractere)
	elif [[ $mascara_senha == $'\x7f' ]] ; then

		if [[ -n $caractere ]] ; then
			caractere=${caractere%?}
		fi

		if [[ -n $senha ]] ; then
			senha=${senha%?}
			printf "\b \b"
		fi

	# Bloqueia teclas ESC, TAB e ESPAÇO
	elif [[ $mascara_senha == $'\x1B' ]] || 
	     [[ $mascara_senha == $'\x09' ]] ||
	     [[ $mascara_senha == $'\x20' ]] ; then
		tput setaf 1
		echo -e "\e[1;5;40m => \e[0;5;41mTacla proíbida!\e[0m"
		tput sgr0
		printf "\r\e[0;5;44m$texto_adm:\e[0m "
		unset senha
		unset caractere

	else
		senha+=$mascara_senha
		caractere+=$mascara_senha

		# Mascara ou caractere (pode alterar)
		printf "\e[32;5m×\e[0m"

		if [[ $senha == $password ]] ; then
			chave_senha=1
			break
		fi

		unset caractere
	fi
done

acesso() {
    tput reset
    echo
    echo
    neofetch --ascii_distro kali_small -L
}

# Execução

[ $chave_usuario == 1 ] && [ $chave_senha == 1 ] && acesso && exit 0
