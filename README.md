<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Licença Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">TreasureHunt{Security}</span> de <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/TreasureHuntGame/TreasureHunt" property="cc:attributionName" rel="cc:attributionURL">Ricardo de la Rocha Ladeira</a> está licenciado com uma Licença <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons - Atribuição-NãoComercial 4.0 Internacional</a>.<br />Baseado no trabalho disponível em <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/TreasureHuntGame/TreasureHunt" rel="dct:source">https://github.com/TreasureHuntGame/TreasureHunt</a>.

# TreasureHunt
TreasureHunt Cybersecurity Game é um jogo de caça ao tesouro, também conhecido como CTF. Neste jogo o objetivo é resolver o máximo de exercícios de Segurança Computacional antes dos concorrentes. Os códigos presentes no repositório representam o gerador de competições (em ``TreasureHunt/Jogo``) e a interface web do jogo (em ``TreasureHunt/TreasureHunt``).

## Ferramentas Necessárias

O jogo exige a instalação das ferramentas abaixo para ser corretamente utilizado. Um script instalador (``instalador.sh``) e uma lista preliminar de pacotes (``requisitos.txt``, por padrão) auxiliam neste processo.

- apache2
- awk
- base32
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
- ngrok (opcional, para não disponibilizar o jogo somente na rede local)
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
- base32
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
2. Entre no diretório Problemas (``cd ~/TreasureHunt/Jogo/Problemas/``)
3. Digite ``bash Jogo.sh``
4. Siga as instruções do jogo e crie os exercícios
### Utilizando o sistema web
1. Copie o diretório ``TreasureHunt`` para o diretório do servidor web (por exemplo: ``/var/www/html/TreasureHunt/``)
2. Inicie o seu servidor web (por exemplo, utilizando o Apache: ``sudo service apache2 start``)
3. Forneça seu IP aos jogadores (verifique em sua interface de rede, por exemplo, digitando ``ifconfig``)
4. Forneça nome de usuário (ID) e senha aos jogadores
5. Quando desejar finalizar a competição, desligue o servidor (por exemplo, utilizando o Apache: ``sudo service apache2 stop``)

Ao finalizar o jogo, as submissões estarão armazenadas na base de dados ``TreasureHunt`` no MySQL.

*Nota 1*: Necessário obter privilégio de administrador no diretorio do servidor web (por exemplo: ``/var/www/html/TreasureHunt/``).

*Nota 2*: O script considera que o MySQL será utilizado com usuário ``root`` e sem senha. O organizador pode alterar isso manipulando a chamada ao script ``ConfiguraBD.sh`` no arquivo ``Jogo.sh``.

*Nota 3*: O script considera que o MySQL será utilizado sem a diretiva ``NO_ZERO_DATE``. Para removê-la, insira no arquivo de configuração: 
[mysqld]  
``sql_mode = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"``
Depois, reinicie o mysql (``sudo service mysql restart``) e tente novamente. Você tambm pode verificar se a diretiva foi removida entrando no mysql e digitando no console: ``SHOW VARIABLES LIKE 'sql_mode';``

*Nota 4*: O arquivo ``apache2.conf``, disponível no diretório ``TreasureHunt/TreasureHunt``, serve apenas como exemplo de configuração do servidor web. O organizador pode configurá-lo de maneira diferente, a seu critério.

*Nota 5*: Arquivos de texto podem apresentar problemas se codificados com iso 8859-1. Prefira utf-8 ou us-ascii.

*Nota 6*: Se você obtiver a mensagem `ERROR 1698 (28000): Access denied for user 'root'@'localhost'`ao final do script, verifique o valor default de autenticação para o seu usuário e altere-o. Isso pode ser feito seguindo os passos abaixo (exemplo para o usuário `root`):
```
> sudo mysql -u root
mysql> USE mysql;
mysql> SELECT User, Host, plugin FROM mysql.user;
mysql> UPDATE user SET plugin='mysql_native_password' WHERE User='root';
mysql> FLUSH PRIVILEGES;
mysql> exit;
> service mysql restart
```
