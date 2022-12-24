## Painel de login para linux
Painel de login básico: 

![Captura](https://github.com/Olliv3r/Linux-Login/blob/main/src/imagens/20221215_235303.jpg)

### Login padrão 
Usuário e Senha padrão: 
`root` 
`toor` 

Pode ser alterado dentro do código nessa linha: 
![Captura](https://github.com/Olliv3r/Linux-Login/blob/main/src/imagens/alterar.jpg)

### *Obs!*
Crie um arquivo chamado `.bash_login` Ou `.bashrc` dentro do diretório raíz do termux e adicione o seguinte:
```
bash $HOME/Linux-Login/login.sh
```

*Sai e entre no termux*

Apartir daí toda vez que entrar ou abrir uma nova aba, ele vai pedir pra preencher os dados de acesso, *so cuidado pra não esquecer os dodos que colocar, pode perder o acesso.*

### Instalação automática: 
```
source <(curl -fsSL https://raw.githubusercontent.com/Olliv3r/Linux-Login/main/install.sh)
```
### Remover:
```
source <(curl -fsSL https://raw.githubusercontent.com/Olliv3r/Linux-Login/main/remove.sh)
```

### Mascara ou caractere
*Você pode escolher se deseja mascarar ou não o usuário e senha, pode alterar nessas linhas:*

#### Usuário:
![Captura](https://github.com/Olliv3r/Linux-Login/blob/main/src/imagens/20221216_001138.jpg)

#### Senha:
![Captura](https://github.com/Olliv3r/Linux-Login/blob/main/src/imagens/20221216_001050.jpg)

### Recursos:

- [x] Mascara de usuário e senha
- [x] Backspace configurado
- [x] Algumas Teclas de atalho desativadas
- [ ] Outros
