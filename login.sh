#!/usr/bin/env bash
# login.sh
#
# Oliver, Setembro de 2010 

# Dados da entrada
unset usuario
unset senha
unset caractere

# Chaves
chave_usuario=0
chave_senha=0

# Login padrão (Pode alterar)
login_usuario="root"
login_senha="toor"

# Mascara
caractere=''

# Cores
w="\e[0m"
r="\e[31m"
g="\e[32m"

# Ctr+c, Ctr+z e etc
trap aviso_teclas_proibidas SIGINT SIGTSTP

# Pacotes necessários
pacotes=(
	"neofetch" 
	"tput"
)

# Instalador de pacotes
instalador() {
    if [ ${1} == ${pacotes[1]} -a ! -f ${PREFIX}/bin/tput ] || [ ${1} != ${pacotes[1]} -a ! -f ${PREFIX}/bin/${1} ] ; then
        printf "\r[*] Instalando pacote ${1}..."
        apt update > /dev/null 2>&1
        apt install $1 -y > /dev/null 2>&1

	if [ ${1} == ${pacotes[1]} -a -f ${PREFIX}/bin/tput ] || [ ${1} != ${pacotes[1]} -a -f ${PREFIX}/bin/${1} ] ; then
	    printf "\r[*] Instalando pacote ${1}...OK\n"
	    sleep 0.5
	fi
    fi
}

# Pacote inexistente
aviso_pacote_inexistente() {
    for ((index = 0; index < ${#pacotes[*]}; index++))
    do
	if [ ${pacotes[index]} == ${pacotes[1]} ] ; then
	    pacotes[index]="ncurses-utils"
	fi

	instalador ${pacotes[index]}
    done
}

# Teclas proibidas
aviso_teclas_proibidas() {
	unset usuario
	unset senha
	unset caractere
	
	tput setaf 1
	echo -e "\e[1;5;40m=> \e[0;5;41mAtalho proíbido!\e[0m"
	tput sgr0
	printf "\e[0;5;44m${texto_usuario_ou_senha}:\e[0m "
}

# Banner
banner() {
   tput reset
   neofetch --ascii_distro kali_small -L
   echo
   echo -n "Linux Login *"
   echo
   echo
}

# Usuário
f_usuario() {

    texto_usuario_ou_senha="Usuário"
    texto_usuario="Usuário"

    printf "\r\e[0;5;44m${texto_usuario}:\e[0m "

    while IFS= read -r -s -n1 mascara_usuario; do

	if [[ -z ${mascara_usuario} ]] ; then
	    tput setaf 1
   	    echo -e "\e[1;5;40m => \e[0;5;41mUsuário inválido!\e[0m"

	    tput sgr0
   	    printf "\r\e[0;5;44m${texto_usuario}:\e[0m "

	    unset usuario
	    unset caractere

	# Backspace (Remove o último caractere)
	elif [[ ${mascara_usuario} == $'\x7f' ]] ; then
	    if [[ -n ${caractere} ]] ; then
		caractere=${caractere%?}
	    fi

	    if [[ -n ${usuario} ]] ; then
		usuario=${usuario%?}
		printf "\b \b"
	    fi
	
	# Bloqueia teclas ESC, TAB e ESPAÇO
	elif [[ ${mascara_usuario} == $'\x1B' ]] || 
	     [[ ${mascara_usuario} == $'\x09' ]] ||
	     [[ ${mascara_usuario} == $'\x20' ]] ; then
	    tput setaf 1
	    echo -e "\e[1;5;40m => \e[0;5;41mTacla proíbida!\e[0m"
	    tput sgr0
	    printf "\r\e[0;5;44m${texto_usuario}:\e[0m "

	    unset usuario
	    unset caractere

	else
	    usuario+=${mascara_usuario}
	    caractere+=${mascara_usuario}

	    # Mascara ou caractere (pode alterar)
	    echo -ne "\e[32;5m${caractere}\e[0m"

	    if [[ ${usuario} == ${login_usuario} ]] ; then
		chave_usuario=1
		break
	    fi

	    unset caractere
	fi
    done
    echo
}

f_senha() {
    texto_usuario_ou_senha="Senha" 
    texto_senha="Senha"

    printf "\r\e[0;5;44m${texto_senha}:\e[0m "

    while IFS= read -r -s -n1 mascara_senha; do

	if [[ -z ${mascara_senha} ]] ; then
	    tput setaf 1
	    echo -e "\e[1;5;40m => \e[0;5;41mSenha inválida!\e[0m"
	    
	    tput sgr0
	    printf "\r\e[0;5;44m${texto_senha}:\e[0m "
	
	    unset senha
	    unset caractere

	# Backspace (Remove o último caractere)
	elif [[ ${mascara_senha} == $'\x7f' ]] ; then
	    if [[ -n ${caractere} ]] ; then
		caractere=${caractere%?}
	    fi

	    if [[ -n ${senha} ]] ; then
		senha=${senha%?}
		printf "\b \b"
	    fi

	# Bloqueia teclas ESC, TAB e ESPAÇO
	elif [[ ${mascara_senha} == $'\x1B' ]] || 
	     [[ ${mascara_senha} == $'\x09' ]] ||
	     [[ ${mascara_senha} == $'\x20' ]] ; then
	    tput setaf 1
	    echo -e "\e[1;5;40m => \e[0;5;41mTacla proíbida!\e[0m"
		
	    tput sgr0
	    printf "\r\e[0;5;44m${texto_senha}:\e[0m "

	    unset senha
	    unset caractere

	else
	    senha+=${mascara_senha}
	    caractere+=${mascara_senha}

	    # Mascara ou caractere (pode alterar)
	    printf "\e[32;5m*\e[0m"

	    if [[ ${senha} == ${login_senha} ]] ; then
		chave_senha=1
		break
	    fi

	    unset caractere
	fi
    done
}

aviso_pacote_inexistente
banner
f_usuario
f_senha

[ ${chave_usuario} == 1 ] && 
[ ${chave_senha} == 1 ] && 
   echo -e "\n\nNew window\n"
