# Guia do Instalador

Alguns programas precisam estar instalados na máquina do organizador para que os _scripts_ geradores de competição funcionem. O instalador deste diretório pode ser utilizado para instalar tais dependências (descritas no arquivo [requisitos.txt](requisitos.txt)). Essa é a execução padrão do _script_ [instalador.sh](instalador.sh). 

Opcionalmente, esse mesmo instalador pode ser executado nas máquinas dos jogadores para instalar um pacote mínimo de ferramentas que solucionam qualquer competição do TreasureHunt. Para usar o _script_ com esse intuito, basta usar o parâmetro [requisitos_user.txt](requisitos_user.txt) ao executar o instalador.     

O instalador busca dar suporte aos seguintes gerenciadores de pacote:

- apt
- apt-get
- yum 
- dnf
- packman

Os erros de instalação são colocados no diretório `logs`. Sinta-se livre para sugerir a adição de outro gerenciador de pacotes ou relatar algum erro de instalação abrindo um _issue_ e/ou entrando em contato com a equipe do projeto. 

## Instalação - Organizador da competição

Para instalar as dependências do gerador de competições, basta executar os comandos abaixo. Certifique-se que você está no diretório [Instalador](/Instalador) (```cd Instalador```). Note que o _script_ precisa de privilégios de super usuário para funcionar.

```sh
    chmod +x instalador.sh
    sudo ./instalador.sh 
    # ou sudo bash instalador.sh
```
 
## Instalação - Usuários

Para instalar as ferramentas mínimas recomendadas aos usuários, execute os comandos abaixo. De forma análoga, é preciso estar no diretório [Instalador](/Instalador) e executar o _script_ com privilégios de super usuário.  

```sh
    chmod +x instalador.sh 
    sudo ./instalador.sh requisitos_user.txt
    # ou sudo bash instalador.sh requisitos_user.txt
```

Nota 1: esse _script_ pode facilitar a tarefa de instalar as ferramentas mínimas em múltiplos computadores, caso esteja trabalhando em uma rede local ou remota. Ele também pode ser passado diretamente aos usuários, a depender das intenções do organizador.

Nota 2: essas ferramentas são apenas sugestões. O usuário é livre para resolver os problemas com as ferramentas desejar. Fica a cargo do organizador decidir se recomenda a instalação dessas ferramentas ou não.

Nota 3: grande parte dessas ferramentas já são instaladas por padrão em grande parte das distribuições Linux:

### lista de ferramentas recomendadas 
- awk
- base32
- base64
- caesar
- outguess
- sed
- sh
- strings
- Editor de texto
- Navegador web
