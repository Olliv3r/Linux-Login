## Painel de login para linux
Painel de login básico: 

### Login padrão 
Usuário e Senha padrão: `root` & `toor`

### Instalação:
```
apt update && apt upgrade -y && apt install wget -y && wget https://raw.githubusercontent.com/Olliv3r/Linux-Login/main/login.sh
```

### Configurar
```
touch $HOME/.bash_login && echo "bash $HOME/login.sh" > $HOME/.bash_login
```
Reinicie o termux e veja o resultado.
### Remover
```
rm -rf $HOME/.bash_login
```

### Recursos:

- [x] Mascara de usuário e senha
- [x] Backspace configurado
- [x] Algumas Teclas de atalho desativadas
- [ ] Outros
