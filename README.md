## Painel de login para linux
Painel de login básico: 

### Login padrão 
Usuário e Senha padrão: `root` & `toor`

### Instalação:
```
apt update && apt upgrade -y && apt install wget -y && wget https://raw.githubusercontent.com/Olliv3r/Linux-Login/main/login.sh
```

### *Obs!*
Crie um arquivo chamado `.bash_login` Ou `.bashrc` dentro do diretório raíz do termux e adicione o seguinte:
```
touch $HOME/.bash_login && echo "bash $HOME/login.sh" > $HOME/.bash_login
```

### Recursos:

- [x] Mascara de usuário e senha
- [x] Backspace configurado
- [x] Algumas Teclas de atalho desativadas
- [ ] Outros
