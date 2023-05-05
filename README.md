## Painel de login para linux
Painel de login básico:
![main](https://github.com/Olliv3r/Linux-Login/blob/main/media/main.jpg)

### Login padrão 
Caso não exista usuário configurado, o usuário e Senha padrão serão: `root` & `toor`

### Instalação:
```
apt update && apt upgrade -y && apt install neofetch python git -y && cd ~ && git clone https://github.com/Olliv3r/Linux-Login
```

### Modo de uso:
Fazer:
```
cd ~/Linux-Login && bash ./setup.sh --setup
```

### Desfazer
Desfazer:
```
cd ~/Linux-Login && bash ./setup.sh --undo
```

### Recursos:

- [x] Mascara de senha
- [x] Backspace configurado
- [x] Algumas Teclas de atalho desativadas
- [x] Configuração de usuário e senha
- [x] Logos aleatórios (opcional)
- [ ] Outros
