<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Licença Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">TreasureHunt{Security}</span> de <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/TreasureHuntGame/TreasureHunt" property="cc:attributionName" rel="cc:attributionURL">Ricardo de la Rocha Ladeira</a> está licenciado com uma Licença <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons - Atribuição-NãoComercial 4.0 Internacional</a>.<br />Baseado no trabalho disponível em <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/TreasureHuntGame/TreasureHunt" rel="dct:source">https://github.com/TreasureHuntGame/TreasureHunt</a>.

# TreasureHunt
TreasureHunt Cybersecurity Game

## Objetivos

### Prioridades
- [x] Criar um instalador para os pacotes necessários.
	 - [ ] Criar 'sintaxe' no ``requirements.txt`` de forma que, pacotes com GUI tenham output no terminal para o usuário interagir.
	 - [ ] Encontrar o pacote ``php7.0-opcache``
	 - Pacotes removidos do ``requirements.txt``, mas precisam ser instalados:
	   - php-opcache [não encontrado]
	   - oracle-java8-installer [instalador GUI]
	   - mysql-server [instalador GUI]
- [ ] Adicionar pontuação ao jogo.

### Outras tarefas
- [ ] Organizar código das soluções.
- [ ] ID da Competição.
- [ ] Tempo de duração da competição (iniciar/pausar).
- [ ] Parametrizar user/senha do mysql.
- [ ] Checagem de parametros com numero negativo (robots)
- [x] Readme.
- [ ] Armazenar flag para id não numérico no sistema web?
- [ ] Validar entradas char quando espera int.
- [ ] Impedir que o jogador 1 pegue o Desafio 2.
- [ ] Verificar de tempos em tempos se o usuário existe.
- [ ] Script de pausa no jogo, stopping apache e armazenando os dados do mysql num arquivo em BD/ ou alguma pasta assim.
- [ ] Proteção contra força bruta.
- [ ] Possibilitar o limite de tentativas por problema.
- [ ] Trocar input do ID na submissão por select.
- [ ] Isolar trafego?
- [ ] IP do emissor de flag.
- [ ] Identificador da máquina que enviou a resposta.
- [ ] Ofuscar nomes das tabelas? Parametrizar?
- [ ] Contar número de linhas dos arquivos de resposta para identificar erros.
- [ ] Alterar a ordem dos problemas (colocar em alfabética).
- [ ] Remover imagens, adicionar script que faça download delas.

## Exige instalação dos seguintes pacotes:
apache2
coreutils
bash
bsdgames
default-jre
default-jdk
grep
libapache2-mod-php
oracle-java8-installer
mysql-client
mysql-server
outguess
php
php-common
php-mysql
php7.0
php-cli
php-common
php-fpm
php-json
php-mysql
php-opcache
php-readline
xxd
zip

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

*Nota 3*: O arquivo apache2.conf, disponível no diretório TreasureHunt/TreasureHunt, serve apenas como exemplo de configuração do servidor web. O organizador pode configurá-lo de maneira diferente, a seu critério.
