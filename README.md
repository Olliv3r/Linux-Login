## Painel de login para linux
Painel de login básico:
![main](https://github.com/Olliv3r/Linux-Login/blob/main/media/main.jpg)

### Login padrão 
Se caso não existir um usuário configurado, o login padrão será: `root` & `toor`

### Instalação:
```
source <(curl -fsSL https://raw.githubusercontent.com/Olliv3r/Linux-Login/main/install.sh)
```

### Modo de uso:
Fazer:
```
bash ~/Linux-Login/setup.sh --setup
```

### Desfazer
Desfazer:
```
bash ~/Linux-Login/setup.sh --undo
```

### Recursos:

- [x] Mascara de senha (opcional)
- [x] Backspace
- [x] Algumas Teclas de atalho desativadas
- [x] Login personalizado (opcional)
- [x] Logo aleatório (opcional)
- [ ] Outros
