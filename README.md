## Painel de login para linux
Painel de login básico: 

### Login padrão 
Usuário e Senha padrão: `root` & `toor`

### Instalação:
```
apt update && apt upgrade -y && apt install neofetch python git -y && cd ~ && git clone https://github.com/Olliv3r/Linux-Login
```

### Configurar
Configurar um usuário e senha, caso queira, o logo aleatório também:
```
bash setup.sh
```

Pedir o acesso na inicialização:
```
touch ~/.bash_login && echo "bash ~/Linux-Login/login.sh" > ~/.bash_login
```
Reinicie o termux e veja o resultado!
```
exit
```

### Desfazer
Remover a linha (que pede o acesso) do arquivo `.bash_login`:
```
sed -i "s/bash ~\/Linux\-Login\/login\.sh//g" ~/.bash_login
```

### Recursos:

- [x] Mascara de senha
- [x] Backspace configurado
- [x] Algumas Teclas de atalho desativadas
- [x] Configuração de usuário e senha
- [x] Logos aleatórios (opcional)
- [ ] Outros
