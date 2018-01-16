# TreasureHunt
TreasureHunt Cybersecurity Game

## Exige instalação das seguintes ferramentas:
- apache2
- awk
- base64
- bash
- bsdgames (pacote que contém a ferramenta caesar)
- cat
- cp
- cut
- default-jre
- default-jdk
- echo
- expr
- grep
- head
- libapache2-mod-php
- libapache2-mod-php7.0
- ls
- mkdir
- mv
- mysql-server-5.5
- mysql-client-5.5
- oracle-java8-installer
- outguess
- php
- php-common
- php-mysql
- php7.0
- php7.0-cli
- php7.0-common
- php7.0-fpm
- php7.0-json
- php7.0-mysql
- php7.0-opcache
- php7.0-readline
- printf
- pyc
- python
- read
- rev
- rm
- sed
- seq
- sh (dash)
- shuf
- sleep
- sort
- strings
- tail
- tr
- wc
- xxd
- zip

Para solucionar os desafios do jogo, sugere-se pelo menos as seguintes ferramentas:
- awk
- base64
- caesar
- outguess
- sed
- sh
- strings
- Editor de texto
- Navegador web


## Como usar?
### Criando os desafios
1. Faça o download dos arquivos deste repositório
2. Entre no diretório Problemas (cd ~/TreasureHunt/Jogo/Problemas/)
3. Digite bash Jogo.sh
4. Siga as instruções do jogo e crie os exercícios
### Utilizando o sistema web
1. Copie o diretório TreasureHunt para o apache2 (coloque em /var/www/TreasureHunt/)
2. Inicie o apache2 (sudo service apache2 start)
3. Forneça seu IP aos jogadores (verifique em sua interface de rede, por exemplo, digitando ifconfig)
4. Forneça nome de usuário (ID) e senha aos jogadores
5. Quando desejar finalizar a competição, desligue o servidor (sudo service apache2 stop)

Ao finalizar o jogo, as submissões estarão armazenadas na base de dados TreasureHunt no MySQL.

*Nota 1*: Necessário obter privilégio de administrador no diretorio /var/www/TreasureHunt/ do apache2.

*Nota 2*: Considera que o MySQL será utilizado com usuário _root_ e sem senha. O organizador pode alterar isso manipulando a chamada ao script ConfiguraBD.sh no arquivo Jogo.sh.

*Nota 3*: O arquivo apache2.conf, disponível no diretório TreasureHunt/TreasureHunt serve apenas como exemplo de configuração do servidor web. O organizador pode configurá-lo de maneira diferente, a seu critério.
