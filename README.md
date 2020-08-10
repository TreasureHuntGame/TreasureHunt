# :trophy: TreasureHunt

> Ferramenta de geração automática de problemas e competições do tipo desafio (também conhecidas como CTF _Jeopardy!_) para ensino de Segurança Computacional

![Interface _web_ do TreasureHunt](Imagens/tela.png)

---

## :pushpin: Tabela de Conteúdos

- [:scroll: Introdução](#scroll-Introdução)
- [:construction_worker: Arquitetura](#construction_worker-Arquitetura)
- [:electric_plug: Instalação](#electric_plug-Instalação)
- [:video_game: Como Jogar](#video_game-Como-Jogar)
- [:mailbox: Autores](#mailbox-Autores)
- [:chart_with_upwards_trend: Funcionalidades Futuras](#chart_with_upwards_trend-Funcionalidades-Futuras)
- [:tada: Como Contribuir](#tada-Como-Contribuir)
- [:closed_book: Licença](#closed_book-Licença)

---

## :scroll: Introdução

Ainda que seja uma área significativa da Computação, a Segurança Computacional apresenta um nítido contraste: a crescente demanda por profissionais _versus_ a carência de profissionais capacitados.

Um dos artifícios usados para atrair talentos em Segurança é o uso de **jogos** e **competições de segurança**, dentre os quais destacam-se os jogos do tipo _desafio_, também chamados de _caça ao tesouro_ e _capture the flag_ (CTF). Nestes jogos o objetivo dos jogadores é obter os textos secretos, também chamados de _flags_, ao aplicar técnicas de Segurança.

Apesar de atrativas aos jogadores, a elaboração dessas competições encara algumas dificuldades:

- Compartilhamento de resposta: _flags_ costumam ser idênticas a todos os competidores, abrindo brecha para trapaça.
- Elaboração de problemas: uma tarefa normalmente trabalhosa e manual, necessitando de conhecimento técnico.
- Reaproveitamento de problemas: problemas (e soluções), quando divulgados na _web_, perdem o "fator surpresa", imprescendível para esse tipo de jogo.

**TreasureHunt** é uma ferramenta destinada a profissionais interessados em organizar competições de Segurança do tipo caça ao tesouro. A ferramenta se propõe a minimizar os problemas supracitados por meio da geração de problemas e competições de forma aleatória, automática e completa.

---

## :construction_worker: Arquitetura

A arquitetura do projeto está descrito no diagrama de atividades a seguir:

![Diagrama de atividades](Imagens/atividades.png)

Nota-se que podemos dividir o projeto em dois grandes módulos:

- Gerador de desafios
- Sistema _Web_

### Gerador de desafios: 

O gerador de desafios é acionado pelo organizador e é composto por um conjunto de _scripts_ e diretórios com recursos como imagens, textos e códigos, localizados em [`TreasureHunt/Jogo`](/Jogo). Esses diretórios são usados como base para criação de instâncias únicas de problemas. Ainda que exista um conjunto de arquivos padrão, o organizador pode modificá-los, adicionando ou removendo-os a seu critério. 

Os _scripts_, por sua vez, são responsáveis por montar a competição, gerar instâncias de problemas e _flags_ únicas para cada jogador, bem como configurar o Sistema de Gerenciamento de Banco de Dados (SGBD). O _script_ principal é chamado de [jogo.sh](Jogo/Problemas/Jogo.sh). Ele recebe a quantidade de jogadores e problemas, os quais podem aplicar técnicas únicas ou compostas de acordo com as entradas do organizador. Por fim, as entradas são validadas, prosseguindo na criação dos arquivos compactados (em formato .zip) que serão enviados para o Servidor _Web_ e na configuração do SGBD. A imagem a seguir demonstra a execução do _script_ principal:

![execução do _script_ principal](Imagens/script.png)

### Sistema Web:

É o componente no qual os jogadores interagem com o jogo, localizando-se em [`TreasureHunt/TreasureHunt`](/TreasureHunt). Nele os usuários têm as seguintes funcionalidades, como também descritas no diagrama de casos de uso: 

![diagrama de casos deuso](Imagens/caso_uso.png)

- Visualizar Instruções e o contato com os desenvolvedores
- Baixar problemas (exige autenticação)
- Submeter respostas (exige autenticação)
- Visualizar o placar indivual ou geral (exige autenticação)

As respostas (_flags_) estão presentes nos arquivos disponibilizados, mas precisam ser encontradas por meio da aplicação das técnicas corretas, como descriptografia de _base64_ ou Cifra de César, por exemplo. 

Ao fim das competições, os resultados podem ser observados pelo organizador no Banco de Dados TreasureHunt. Nele ficam registrados inclusive o endereço IP dos jogadores, o que garante que uma conta não tenha sido compartilhada, por exemplo. Vale lembrar que boas práticas de Segurança são aplicadas nos dados sensíveis, tais como o uso de _hash_ e _salt_.

---

## :electric_plug: Instalação

Para promover uma competição com o TreasureHunt é necessário seguir os seguintes passos:

1. Clonagem do repositório
2. Execução do _script_ de instalação de requisistos
3. Execução do _script_ de geração de competições
4. Configuração e inicialização do servidor _web_

Passos adicionais, tais como instalação de ferramentas alternativas ou configuração de servidores instalados, podem ser necessários. Leia também a seção sobre [Problemas Frequentes](#Problemas-Frequentes-na-Instalação). 

O restante dessa seção descreve detalhadamente cada um dos passos sugeridos.

### Clonagem

Para copiar o repositório, execute o seguinte comando [Git](https://git-scm.com/) em um terminal:

```sh
 git clone https://github.com/TreasureHuntGame/TreasureHunt.git
```

Para prosseguir a instalação, certifique-se de estar no diretório do TreasureHunt:

```sh
cd TreasureHunt
```

### Instalação de Requisitos e Ferramentas 

Após baixar o repositório para a sua máquina, o próximo passo é fazer a instalação dos requisitos do projeto. Para isto, basta executar o _script_ [`instalador.sh`](/Instalador/instalador.sh), localizado em [`TreasureHunt/Instalador`](/Instalador), que se encarrega de instalar todos os pacotes, que por padrão se encontram no arquivo [`requisitos.txt`](/Instalador/requisitos.txt).

```sh
cd instalador
chmod +x instalador.sh
./instalador.sh
```

Para as máquinas dos jogadores, sugere-se que estas tenham pelo menos as seguintes ferramentas (ou equivalentes):

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

Cabe ao organizador da competição decidir se fornece ou não as ferramentas.

### Geração da Competição

As competições de TreasureHunt precisam ser criadas pelo organizador. Para tanto, este deve escolher a quantidade de participantes, bem como quantos e quais desafios estarão presentes, podendo inclusive adicionar um problema composto, onde duas técnicas são aplicadas em conjunto.

Para gerar a competição, basta executar o _script_ [`jogo.sh`](/Jogo/Problemas/Jogo.sh) do diretório [TreasureHunt/jogo/problemas/](/Jogo/Problemas).

```sh
cd jogo/problemas
chmod +x jogo.sh
./jogo.sh
```

#### Opções de Problemas

O TreasureHunt permite que o organizador da competição gere problemas a partir de um rol de técnicas selecionadas e implementadas. Atualmente é possível gerar problemas envolvendo as técnicas abaixo:

- Comentário em código-fonte de página HTML (_HyperText Markup Language_)
- Comentário no arquivo `robots.txt`
- (De)codificação de arquivo em base64
- (De)codificação de arquivo em base32
- (Des)criptografia de Cifra de César
- (De)codificação de caractere ASCII (_American Standart Code for Information Interchange_)
- Descompilador binário e obter fonte Java
- Descompilador binário e obter fonte Python
- Esteganografia em imagens

Vale lembrar que os problemas podem ser compostos por duas técnicas, ainda que nem todas as combinações sejam possíveis (o _script_ avisará o organizador neste caso). Além disso, a ordem de composição das técnicas interfere no problema (não é comutativa) e na sequência de passos necessários para solucioná-lo.

Com o fim desses passos, o esquema e as tabelas também terão sido criadas automaticamente no Banco de Dados.

### Configuração e Inicialização do Servidor Web

Para iniciar a interface _web_ basta seguir os seguintes passos:

1. Copie o diretório [/TreasureHunt](/TreasureHunt) para o diretório do servido web. Dependendo do sistema operacional e do servidor _web_ este se localizará em locais diferentes. Exemplos: `C:\xampp\htdocs` com o Xampp no Windows ou `/var/www/html/TreasureHunt/` em certas distribuições Linux:

```sh
cp TreasureHunt /var/www/html/TreasureHunt/
```

2. Inicie o servidor _web_. Exemplo de inicialização do apache: 

```sh
sudo service apache2 start
```

3. Forneça acesso aos jogadores através do _link_ gerado pelo [`ngrok`](https://ngrok.com/) ou informando seu endereço IP. Neste caso, verifique em sua interface de rede, por exemplo, digitando ``ifconfig``.

4. Forneça um identificador de usuário (ID) e uma senha de acesso a cada jogador. Eles usarão essas informações para se autenticar na aplicação _web_ posteriormente.

5. Acompanhe o jogo pelo tempo que achar necessário. Sugere-se projetar o placar geral para os jogadores.

6. Finalize a competição quando e como desejar, por exemplo, parando o servidor. Exemplo de parada do apache:

```sh
sudo service apache2 stop
```

Ao finalizar o jogo, as respostas e submissões estarão armazenadas na base de dados ``TreasureHunt`` no MySQL. Sugere-se a realização de _backup_ dos dados através do comando ``mysqldump -u root TreasureHunt > backup.sql`` (supondo usuário ``root``e _database_ ``TreasureHunt``.)

### Problemas Frequentes na Instalação

Pressupõe-se algumas condições para que a instalação ocorra com sucesso. Essas indicações, bem como alguns dos erros comuns serão destacados a seguir:

- *Nota 1*: Necessário obter privilégio de administrador no diretorio do servidor _web_ (por exemplo: ``/var/www/html/TreasureHunt/``).

- *Nota 2*: O _script_ considera que o MySQL será utilizado com usuário ``root`` e sem senha. O organizador pode alterar isso manipulando a chamada ao _script_ ``ConfiguraBD.sh`` no arquivo ``Jogo.sh``.

- *Nota 3*: O _script_ considera que o MySQL será utilizado sem a diretiva ``NO_ZERO_DATE``. Para removê-la, insira no arquivo de configuração: 
[mysqld]  
``sql_mode = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"``
Depois, reinicie o mysql (``sudo service mysql restart``) e tente novamente. Você também pode verificar se a diretiva foi removida entrando no MySQL e digitando no console: ``SHOW VARIABLES LIKE 'sql_mode';``

- *Nota 4*: O arquivo ``apache2.conf``, disponível no diretório ``TreasureHunt/TreasureHunt``, serve apenas como exemplo de configuração do servidor web. O organizador pode configurá-lo de maneira diferente, a seu critério.

- *Nota 5*: Arquivos de texto podem apresentar problemas se codificados com iso 8859-1. Prefira utf-8 ou us-ascii.

- *Nota 6*: Se você obtiver a mensagem `ERROR 1698 (28000): Access denied for user 'root'@'localhost'` ao final do _script_, verifique o valor _default_ de autenticação para o seu usuário e altere-o. Isso pode ser feito seguindo os passos abaixo (exemplo para o usuário `root`):

```SQL
> sudo mysql -u root
mysql> USE mysql;
mysql> SELECT User, Host, plugin FROM mysql.user;
mysql> UPDATE user SET plugin='mysql_native_password' WHERE User='root';
mysql> FLUSH PRIVILEGES;
mysql> exit;
> service mysql restart
```

---

## :video_game: Como Jogar

### Descrição do jogo

Por meio da interface _web_, os jogadores podem:

- Ler as intruções do jogo e o contato dos desenvolvedores
- Baixar o arquivo com os seus respectivos problemas 
- Enviar as respostas (_flags_) dos problemas
- Exibir o placar individual 
- Exibir o placar geral

Apesar disso, para visualizar o placar, baixar os problemas e submeter as respostas é preciso estar autenticado, ou seja, é preciso fazer _login_ com o ID e senha fornecidos pelo organizardor da competição.

Dessa forma, os passos necessários para jogar o TreasureHunt são:

1. Autenticar-se no _site_ com ID e senha. 
2. Baixar o arquivo compactado com os problemas e descompactá-lo. Os diretórios dentro do arquivo compactado são números que representam o ID do problema. Dentro de cada diretório há um ou mais arquivos que precisam ser analisados para se obter a _flag_ do respectivo problema.
3. Utilizar as ferramentas adequadas e encontrar as _flags_ nos arquivos. As _flags_ estaro sempre no formato ``TreasureHunt{TEXTO_ALEATÓRIO}``. Exemplo: ``TreasureHunt{xjYui87aZl}``.
4. Submeter a _flag_ juntamente do número identificador do diretório (ID do problema) no qual a _flag_ foi encontrada.

Após submeter uma _flag_, o jogador receberá uma das seguintes respostas:

- **Problema com ID inválido**: refere-se ao número do problema, o mesmo que nomeia o diretório. Este erro indica que o número informado não corresponde aos problemas do jogo. Exemplos: números negativos ou maiores que a quantidade de questões da competição.
- **Errou!**: a _flag_ está com o formato correto, mas a resposta está incorreta.
- **Errou! Considere submeter a flag no seguinte formato: TreasureHunt{texto-aleatorio}**: indica que o formato da _flag_ está incorreto.
- **Você já acertou a questão ID_problema!**: essa questão já foi respondida corretamente anteriormente (um acerto não é contado duas vezes).
- **Acertou! n/m**: a questão foi respondida corretamente. É indicada quantas questões (n) do total (m) já foram acertadas.

Ao longo da competição o jogador tem a opção de visualizar quais problemas faltam ser resolvidos no placar indivual e sua colocação em relação aos demais jogadores no placar geral.

Vencerá o jogo aquele que submeter mais respostas em menos tempo, ou seja, em caso de empate no número de acertos, permanecerá à frente aquele que submeteu a última resposta correta primeiro.

Vale lembrar que para a execução dos problemas recomenda-se um conjunto mínimo de ferramentas, descritas no final da seção [Instalação de Requisitos e Ferramentas](#Instalação-de-Requisitos-e-Ferramentas). Apesar disso, o jogador é livre para escolher a forma como resolverá os problemas, incluindo ferramentas alternativas ou _scripts_ automatizados para a resolução dos problemas.

---

## :mailbox: Autores

### Equipe atual

- Ricardo de la Rocha Ladeira: [ricardo.ladeira@ifc.edu.br](mailto:ricardo.ladeira@ifc.edu.br)
- Vítor Augusto Ueno Otto: [vitoruenootto@gmail.com](mailto:vitoruenootto@gmail.com)

### Contribuidores

- Henrique Arnicheski Dalposso
- Rafael Rodrigues Obelheiro
- Richard Robert Dias Custódio
- Vinícius Manuel Martins

---

## :chart_with_upwards_trend: Funcionalidades Futuras

Este projeto se mantém em constante atualização, o que significa que novas funcionalidades e aperfeiçoamentos continuarão a ser feitos ao longo do tempo. Algumas dessas modificações possuem caráter duradouro, como é o caso da criação de novas possibilidades de problemas no gerador de desafios. Dentre as funcionalidades planejadas, pretende-se:

- Criar novos problemas no gerador de desafios, em especial da classe de problemas _web_
- Permitir que mais de duas técnicas componham um problema (por exemplo, elaborar um problema que envolva base64, base32 e Cifra de César)
- Permitir que mais de uma ferramenta seja utilizada por técnica (por exemplo, elaborar problemas de esteganografia envolvendo `outguess`, `f5.jar` e `steghide`)
- Permitir o cadastro autônomo e o gerenciamento das contas de usuários
- Permitir a parametrizaço de pontos, ou seja, atribuir pontuações diferentes aos problemas
- Implementar um recurso para inserção de dicas
- Adicionar identificadores às competições, permitindo melhor acompanhamento da evolução dos jogadores, por exemplo.
- Fornecer uma interface de treinamento inteligente para analisar as respostas e o tempo levado pelos jogadores para recomendar problemas de dificuldade adequada.

---

## :tada: Como Contribuir

Sua contribuição é bem-vinda no projeto! Sinta-se livre para relatar _bugs_, impressões ou sugerir mudanças, tanto por meio da criação de **issues** e **pull requests** quanto pelo contato direto com a [equipe atual](#Equipe-atual). Pedimos apenas que utilize uma linguagem clara, descrevendo o seu ambiente e o passo a passo para reproduzir o _bug_. Seja breve e objetivo, mostrando _prints_ se possível.

---

## :closed_book: Licença

<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Licença Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">TreasureHunt{Security}</span> de <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/TreasureHuntGame/TreasureHunt" property="cc:attributionName" rel="cc:attributionURL">Ricardo de la Rocha Ladeira</a> está licenciado com uma Licença <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons - Atribuição-NãoComercial 4.0 Internacional</a>.
<br />Baseado no trabalho disponível em <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/TreasureHuntGame/TreasureHunt" rel="dct:source">https://github.com/TreasureHuntGame/TreasureHunt</a>.

---
