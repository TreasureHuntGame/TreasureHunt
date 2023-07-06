#!/bin/bash

# Ao executar, certifique-se de que você está executando os serviços apache e mysql
# MySQL deve estar rootado sem senha e as tabelas TreasureHunt.Usuario e TreasureHunt.Resposta, caso existam, serão esvaziadas

# Identificador do último problema
MAX=9

# Define o diretório que receberá os desafios
DESTINO_DESAFIOS="/var/www/html/TreasureHunt/Desafios/"
CAMINHO_SITE="/var/www/html/TreasureHunt"
DESTINO_RESPOSTAS="../Respostas"

# Diretório desse script
DIR_SCRIPT=`dirname $0` 

# Array que armazenará o identificador de cada problema
PROBLEMAS=

# Função que habilita o alto contraste no terminal
# Inicialmente esta função testa se a tela já está no contraste máximo, ou seja, se as cores
# branco e preto já estão sendo utilizadas em background e foreground. Se não estiver, fornece
# as opções para o usuário.
altoContraste() {
	if [[ (($R1 != "rgb:ffff/ffff/ffff" && $R1 != "rgb:FFFF/FFFF/FFFF") || $R2 != "rgb:0000/0000/0000") && (($R2 != "rgb:ffff/ffff/ffff" && $R2 != "rgb:FFFF/FFFF/FFFF") || $R1 != "rgb:0000/0000/0000") ]]; then
	    while true; do
	        echo "Habilitar alto contraste?"
	        echo "1: Sim"
	        echo "2: Não"
	        echo "Obs.: ao finalizar o script, suas cores padrão serão restauradas."
	        echo "----------"
	        read -p "Digite uma das opções acima: " OPCAO
	        echo "----------"   
	        case $OPCAO in
	            1|2) break ;; 
	            *) echo -e "Opção inválida, digite novamente! " && sleep 1;;
	        esac
	    done

	    # Se optar pelo alto contraste, o texto ficará preto e o fundo branco.
	    if [ $OPCAO = 1 ]; then
	        echo -ne '\e]11;#FFFFFF\e\\'
	        echo -ne '\e]10;#000000\e\\'
	    fi  
	fi
}

pegaCoresTerminal() {
    oldstty=$(stty -g)
    Ps=${1:-11}
    stty raw -echo min 0 time 0
    printf "\033]$Ps;?\033\\"
    sleep 0.2
    read -r answer
    result1=${answer#*;}
    stty $oldstty
    sleep 0.2
    oldstty=$(stty -g)
    Ps=${1:-10}
    stty raw -echo min 0 time 0
    printf "\033]$Ps;?\033\\"
    sleep 0.2
    read -r answer
    result2=${answer#*;}
    stty $oldstty
    R1=$(echo $result1 | sed 's/[^rgb:0-9a-f/]\+$//')
    R2=$(echo $result2 | sed 's/[^rgb:0-9a-f/]\+$//')
}

restauraCores() {
    echo -ne "\033]11;$R1\007"
    echo -ne "\033]10;$R2\007"
}

# Função que verifica se o parâmetor informado é positivo.
obtemValor() {
	while [ $LOCAL -le 0 ]; do
		read -p "Informe a quantidade de $1: " LOCAL
	done
}

# Função que verifica se o parâmetro informado é válido
verificaParametro() {
	# Verifica se o valor é válido (entre 1 e 9).
	case $1 in
		1|2|3|4|5|6|7|8|9) ;;
		*) erroParametro ;;
	esac
}

# Função que verifica se a composição informada é válida
verificaComposicao() {
	case $PROBLEMA1 in
		# O problema 1 e o problema 9 podem ser compostos com todos os problemas
		# O problema 2 pode ser composto com todos, exceto
		# com os problemas 2 e 5
		# O problema 5 pode ser composto com todos, exceto
		# com o problema 2
		1|2|5|9) 
		case $PROBLEMA2 in
			1|3|4|6|7|8|9) ;;
			*)
			if ([ $PROBLEMA1 -eq  1 ] && ([ $PROBLEMA2 -eq 2 ] || [ $PROBLEMA2 -eq 5 ])) || ([ $PROBLEMA1 -eq 5 ] && [ $PROBLEMA2 -eq 5 ]) || ([ $PROBLEMA1 -eq  9 ] && ([ $PROBLEMA2 -eq 2 ] || [ $PROBLEMA2 -eq 5 ]))
				then LOCK=0
				else LOCK=1
			fi ;;
		esac ;;
		# Os problemas 3, 4, 6, 7 e 8 são compostos
		# somente com os problemas 1, 2, 5, 8 e 9
		3|4|6|7|8)
		case $PROBLEMA2 in
			1|2|5|8|9) ;;
			*) LOCK=1 ;;
		esac ;;
	esac

	# Se a variável LOCK = 1, então tem-se um erro de composição
	if [ $LOCK -eq 1 ]; then
		erroComposicao
	fi
}

# Função que verifica os parâmetros informados
verificaParametros() {
	# Variável que indica se há composição inválida. 1 = Erro.
	LOCK=0

	# O programa verifica a quantidade de parâmetros informados
	case $# in
		# Chama a função que verifica se o parâmetro $1 é válido
		1) verificaParametro $PROBLEMA1 ;;
		# Chama a função que verifica se o parâmetro $1 é válido
		2) verificaParametro $PROBLEMA1	
		# Chama a função que verifica se o parâmetro $2 é válido
		verificaParametro $PROBLEMA2
		# Chama a função que verifica se a composição é válida
		verificaComposicao ;;
		# Um erro é exibido se o número de parâmetros não for 1 ou 2
		*) erroNumParametros ;;	
	esac
}

# Função de erro no intervalo entre os parâmetros
erroParametro() {
	echo "----------"
	echo "O(s) parâmetro(s) deve(m) estar entre 1 e $MAX."
	echo "----------"
	LOCK=1
}

# Função de erro na quantidade de parâmetros
erroNumParametros() {
	echo "----------"
	echo "O programa só aceita 1 ou 2 parâmetros."
	echo "Sintaxe: A [B]"
	echo "onde A e B são os identificadores dos problemas."
	echo "----------"
	LOCK=1
}

# Função de erro de composição inválida ou inexistente
erroComposicao() {
	echo "----------"
	echo "Composição inválida ou inexistente."
	echo "----------"
	LOCK=1
}

# Verifica se existe um Log já criado; se existe retorna 0 
existeLog() {
	[ -f "Log" ] && return 0
}

# Verifica se existe algum diretório numérico; se existir algum retorna 0
existeDirNumericos() {
	for d in ../*; do 
        f=`echo $d | cut -b 4-`
        [[ $f =~ ^[0-9]+$ ]] && return 0
    done 
}

# verifica se existe arquivo de resposta; se existir retorna 0
existeRespostas() {
	mkdir -pm 755 ../Respostas
    for f in ../Respostas/*; do 
        [ -s $f ] && return 0    
    done  
}

# verifica se existe arquivos de respostas compactados no diretório 
# Desafios do servidor web; se existir retorna 0 
# $1 diretório
existeZip() {
	local="$1*"
	for f in $local; do 
        [ -s $f ] && return 0
	done
}

# Função que cria o log do jogo
criaLog() {
	NOME_LOG="Log"
	IDC=`date +%d/%m/%Y_%H:%M:%S`
	echo "---------- BEGIN TH{LOG} ----------" > $NOME_LOG
	echo "IDC: Competição_$IDC  " >> $NOME_LOG
	echo "QUANT_DESAFIOS: $QUANT_DESAFIOS" >> $NOME_LOG
	echo "QUANT_JOGADORES: $QUANT_JOGADORES" >> $NOME_LOG
	for (( i=1; i<=$QUANT_DESAFIOS; i++ )); do
		echo "Desafio $i: ${PROBLEMAS[$i]}" >> $NOME_LOG
	done 
	echo -e "---------- Log Detalhado ----------" >> $NOME_LOG
	cat Logger >> Log 
	echo "---------- END TH{LOG} ----------" >> $NOME_LOG
	rm -f Logger 
}

# Move os arquivos de log, diretórios numéricos, respostas e zips
# para um diretório nomeado com timestamp 
moveArquivosCompeticoes() {
	TS=`date +%d-%m-%y_%H-%M-%S`
	OLD_DIR="../OLD_$TS"
	echo -e "Movendo arquivos para o diretório TreasureHunt/Jogo/OLD_$TS." && sleep 0.2
	mkdir -p $OLD_DIR
	existeLog && mv Log $OLD_DIR # move o log 
	if existeDirNumericos; then # move os diretóritos numéricos
		for d in ../*; do 
			f=`echo $d | cut -b 4-`
			if [[ $f =~ ^[0-9]+$ ]]; then 
				cp -r $d $OLD_DIR && rm -rf $d
			fi 
		done 
	fi
	if existeRespostas; then # move as respostas
		cp -r ../Respostas $OLD_DIR && rm -rf ../Respostas   
		mkdir -pm 755 ../Respostas/
	fi 

	if existeZip $DESTINO_DESAFIOS; then # apagar os zips
		for f in "$DESTINO_DESAFIOS*"; do 
			rm -f $f 
		done
	fi

	if existeZip ".."; then 
		rm -rf Jogador*.zip
	fi

	logger "Usuário escolheu mover os arquivos de competições anteriores para o diretórito $OLD_DIR;"
	echo "----------"
}

# Função exclui os arquivos de log, diretórios numéricos, respostas e zips
# $1 = mensagem que será passada ao logger
excluiArquivosCompeticao() {
	if [ $# -eq 0 ]; then 
		echo -e "Removendo arquivos."  && sleep 0.5
	fi 

	existeLog && rm -f Log # Apagar log

	if existeRespostas; then # Apaga respostas
		rm -rf ../Respostas 
		mkdir -pm 755 ../Respostas/ 
	fi
	for d in ../*; do  # Apaga diretórios numéricos
		f=`echo $d | cut -b 4-`
		if [[ $f =~ ^[0-9]+$ ]]; then 
			rm -rf $d 		
		fi  
	done 
	if existeZip $DESTINO_DESAFIOS; then # Apaga os zips
		for f in $DESTINO_DESAFIOS*; do 
			rm -f $f 
		done
	fi

	if existeZip ".."; then 
		rm -f Jogador*.zip
	fi

	resetaEasterEgg

	if [ $# -eq 0 ]; then 
		logger "Usuário escolheu excluir arquivos de competições anteriores;"
	else 
		logger $1
	fi 
	echo "----------"
}

# Aborta script
# $1 mensagem passada ao logger 
abortaScript() {
	if [ $# -eq 0 ]; then
		logger "Usuário escolheu abortar script;"
		echo -e "Abortando o script! " && sleep 1
	else 
		logger $1
		echo -e "$1"  && sleep 1
	fi 

	restauraCores
	exit 1
}

# Exclui logger 
excluiLogger() {
	[ -f Logger ] && rm "Logger"
}

# Verifica se existe algum arquivo de competição antigo. 
# Se existir, pergunta ao usuário o que ele deseja fazer
manejaArquivosCompeticoesAntigos() {
	# Se algum arquivo de outra competição já estiver criado 
	if existeLog || existeDirNumericos || existeRespostas; then
		logger "Arquivos de competições anteriores foram encontrados;"
		while true; do  # Pergunta o que o usuário deseja fazer
			echo "Arquivos de competições anteriores foram encontrados! "
			echo "----------"
			echo "lista de opções disponíveis: "
			echo "1: Mover arquivos antigos para um diretório criado automaticamente."
			echo "2: Excluir todos os arquivos antigos."
			echo "3: Abortar o script."
			echo "----------"
			read -p "Digite uma das opções acima: " OPCAO
			echo "----------"
			case $OPCAO in 
				1|2|3) break;;
				*) echo "Opção inválida, digite novamente! " && sleep 1;;
			esac 
		done

		if [ $OPCAO = "1" ]; then # Se escolher 1, move tudo para a pasta OLD
			moveArquivosCompeticoes

		elif [ $OPCAO = "2" ]; then # Se escolher 2, exclui os arquivos
			excluiArquivosCompeticao

		elif [ $OPCAO = "3" ]; then # se escolher 3, sai do script
			abortaScript
		fi    
	fi 
}

# Função que loga detalhadamente 
# $1 mensagem
logger() {
	[ ! -f Logger ] && touch Logger
	ts=`date +%d-%m-%y_%H-%M-%S`
	echo "$ts: $1" >> Logger
}

# Exclui arquivos da competição atual e tenta recriá-la usando a lista de problemas $PROBLEMAS
recriaCompeticao() {
	logger "Iniciando processo de recriação;"
	echo -e "Tentando recriar competição para solucionar o problema" && sleep 0.5
	excluiArquivosCompeticao "Excluindo arquivos da competição para tentar recriá-la"
	for i in $(seq $QUANT_DESAFIOS); do # Para cada desafio
		PROB1=`echo ${PROBLEMAS[$i]} | cut -c1`
		PROB2=`echo ${PROBLEMAS[$i]} | cut -c2`
		MENSAGEM_LOG="Desafio $i recriado. Composição do problema: $PROBLEMA1 $PROBLEMA2"
		geraDesafio $PROB1 $PROB2 $MENSAGEM_LOG
	done 
	geraArquivosResposta
}

# Para cada arquivo de resposta verifica se o número de respostas bate 
# Com o número de jogadores; se não bater tenta recriar competição 
verificaRespostas() {
	# Se não existe arquivo de respostas retorna status de erro
	[ ! existeRespostas ] && return 1 
	logger "Checando arquivos de resposta da competição;" 
	echo -e "Verificando se o número de jogadores coincide com o número de respostas geradas..." && sleep 0.4
	RECRIAR="0"
	for f in ../Respostas/*; do 
		L=`cat $f | sed '/^\s*$/d' | wc -l` 
		# LINHAS=`echo "$L - 1" | bc`
		# echo "linhas: $L; linhas - 1: $LINHAS; quantidade de jogadores: $QUANT_JOGADORES"
		if [ $L != $QUANT_JOGADORES ]; then 
			logger "Erro: o número de respostas do arquivo $f não bate com o número de jogadores ($QUANT_JOGADORES);"
			RECRIAR="1"
		else 
			logger "Arquivos de resposta $f checado com sucesso: número de respostas bate com número de jogadores;"
		fi 
	done 
	
	if [ $RECRIAR = "1" ]; then 
		recriaCompeticao
		echo "Número de respostas de um ou mais arquivos não coincide com o total de jogadores"
		return "1"
	fi
}

# Função que gera um desafio individualmente
# $1 problema 1
# $2 problema 2
# $3 mensagem pro log
geraDesafio() {
	PROBLEMA1=$1
	if ! [[ "$2" =~ ^[0-9]+$ ]]; then 
		PROBLEMA2=""
		MENSAGEM=$2
	else 
		PROBLEMA2=$2
		MENSAGEM=$3
	fi

	verificaParametros $PROBLEMA1 $PROBLEMA2
	DESAFIO_ATUAL="$PROBLEMA1 $PROBLEMA2"

	if [ $LOCK -eq 0 ]; then
		sh Composer.sh $QUANT_JOGADORES $i $PROBLEMA1 $PROBLEMA2
		if [ -z $3 ]; then
			echo "Adicionando o desafio $PROBLEMA1 $PROBLEMA2 à competição." && sleep 0.5
			# PROBLEMAS[$i]=$PROBLEMA1$PROBLEMA2
			PROBLEMAS+=($PROBLEMA1-$PROBLEMA2)
			logger "Desafio $DESAFIO_ATUAL adicionado a competição;"
		else 
			logger $MENSAGEM
		fi 
	fi
}

# Função que gera arquivos de resposta que são enviados ao diretório Respostas
geraArquivosResposta() {
	echo -e "Obtendo as soluções..."
	logger "Obtenção das soluções dos desafios..."
	# Caso não exista, cria o diretório que conterá as respostas
	mkdir -pm 755 ../Respostas/
	for i in $(seq $QUANT_DESAFIOS); do
		sh "../Solucoes/sol${PROBLEMAS[$i]}.sh" $QUANT_JOGADORES $i > "../Respostas/Respostas_Desafio_$i"
		echo -e "Resposta(s) do desafio $i gerada(s) em TreasureHunt/Jogo/Respostas/Respostas_Desafio_$i."
		dir=`readlink -f ../Respostas`
		logger "Resposta(s) do desafio $i gerada(s) em Respostas_Desafio_$i ($dir);"
	done
}

# Comprime os desafios do jogador em um arquivo zip
compactaDesafios() {
	for i in $(seq $QUANT_JOGADORES); do
		zip -r -q "../Jogador$i.zip" "../$i/"
		logger "Compressão do arquivo do jogador $i (Jogador$i.zip);"
	done
}

# Se o usuário teclar 1, mantém os arquivos originais. Caso contrário exclui as pastas dos jogadores
manejaArquivosAtuais() {
	while true; do
		echo -e "----------"
		echo "Deseja manter os arquivos originais na pasta do jogo? Caso negativo, os"
		echo "arquivos estarão presentes somente no servidor web."
		echo -e "----------"
		echo "Lista de opções disponíveis:"
		echo "1: Manter os arquivos originais."
		echo "2: Remover os arquivos originais."
		echo -e "----------"
		read -p "Digite uma das opções acima: " RESOLVER
		echo -e "----------"
		case $RESOLVER in
			1|2) break ;; 
			*) echo -e "Opção inválida, digite novamente! " && sleep 1;;
		esac 
	done
	

	if [ $RESOLVER = "1" ]; then
		logger "Usuário decidiu manter arquivos originais;"
		echo -e "Mantido arquivos originais."
	fi 

	if [ $RESOLVER = "2" ]; then 
		logger "Usuário decidiu excluir arquivos originais;"
		for i in $(seq $QUANT_JOGADORES); do
			echo -e "Removendo o diretório do jogador $i." && sleep 0.4
			rm -rf "../$i/"
			logger "Removendo o diretório do jogador $i;" && sleep 0.4
		done
	fi
}

enviaDesafiosCompactados() {
	mkdir -pm 755 $DESTINO_DESAFIOS
	for i in $(seq $QUANT_JOGADORES); do
		mv "../Jogador$i.zip" $DESTINO_DESAFIOS
		dir=`readlink -f $DESTINO_DESAFIOS`
		logger "Jogador$i.zip enviado para diretório Desafios ($dir);"
	done
}

# Função principal que recebe os desafios do usuário, valindando-os 
# e salvando-os num array em sequência o problema é gerado 
manejaEscolhaDesafios() {
	echo -e "----------"
	echo "Vamos criar os desafios!"
	echo "----------"

	logger "Iniciado criação de desafios;"
	for i in $(seq $QUANT_DESAFIOS); do
		LOCK=1

		while [ $LOCK -eq 1 ]; do
			echo "Lista de problemas disponíveis:"
			echo "1: (De)codificação de arquivo em base64."
			echo "2: (Des)criptografia de Cifra de César."
			echo "3: Comentário em código-fonte de página HTML."
			echo "4: Comentário no arquivo robots.txt."
			echo "5: (De)codificação de caractere ASCII para inteiro."
			echo "6: Descompilar binário e obter fonte Java."
			echo "7: Descompilar binário e obter fonte Python."
			echo "8: Esteganografia em imagens."
			echo "9: (De)codificação de arquivo em base32."
			echo "Obs.: escolha 1 ou 2 problemas. Exibiremos uma mensagem de erro se a composição não existir."
			echo "----------"

			read -p "Informe o(s) problema(s) do desafio $i: " PROBLEMA1 PROBLEMA2

			geraDesafio $PROBLEMA1 $PROBLEMA2  
		done

		echo "----------"
		echo "Problema gerado!"
		echo -e "----------"
	done

}

# Função que verifica se usuário quer ativar o ngrok
# Caso alguma instância do ngrok já esteja ativa, o avisa que
# Todas as instâncias (exceto a desse script) serão fechadas 
manejaAtivacaoNgrok() {
	logger "Verificando se usuário quer iniciar o ngrok;"
	while true; do
		echo -e "----------"
		echo "Deseja iniciar o ngrok para criar uma URL de acesso a um túnel de rede seguro?"
		echo "Essa URL pode ser compartilhada para que os jogadores tenham acesso ao jogo."
		echo "----------"
		echo "Lista de opções disponíveis: "
		echo "1: Ativar ngrok."
		echo "2: Não ativar o ngrok (finalizar o script)."
		if pgrep -U $USER ngrok > /dev/null 2>&1 ; then
			echo "Obs: Uma ou mais instâncias do ngrok já estão ativas no seu computador." 
			echo "Se você optar por ativar o ngrok, as demais instâncias serão finalizadas."
		fi
		echo "----------"
		read -p "Digite uma das opções acima: " OPCAO
		echo "----------"
		case $OPCAO in
			1|2) break ;; 
			*) echo -e "Opção inválida, digite novamente! " && sleep 1;;
		esac 
	done	
	
	if [ $OPCAO = "2" ]; then 
		logger "Usuário decidiu não iniciar o ngrok: finalizando script;"
		echo "Prosseguindo sem ativar o ngrok." && sleep 0.5
		echo "Script finalizado."
		echo "----------"
		return 0
	fi 
	logger "Usuário decidiu iniciar o ngrok;"

	if  pgrep -U $USER ngrok > /dev/null 2>&1 ; then 
		logger "Outras instâncias do ngrok foram encontradas: finalizando-as;"
		killall -u $USER ngrok
	fi

	echo "Script finalizado."
	echo "----------"
	echo "Ativando o ngrok." && sleep 0.5
	logger "Ativando ngrok;"
	logger "Script finalizado;"
	criaLog
	exec ngrok http 80
}

# Função que busca por um termo e adiciona um texto uma linha após o termo ser encontrado
# $1 = caminho do arquivo onde ocorrerá a adição da linha  
# $2 = termo a ser buscado no arquivo informado  
# $3 = texto a ser colocado uma linha após o termo buscado
adicionaLinhaAposTermo() {
	CAMINHO_ARQUIVO=$1
	TERMO_BUSCA=$2
	TEXTO=$3 
	LINHA=$((`grep -n -m 1 $TERMO_BUSCA $CAMINHO_ARQUIVO | sed  's/\([0-9]*\).*/\1/'`+1))
	ADICAO="$LINHA i $TEXTO"
	sed -i "$ADICAO" $CAMINHO_ARQUIVO
}	

# Função que apaga uma linha de texto se ela existir em um arquivo
# $1 = caminho do arquivo onde ocorrerá a adição da linha  
# $2 = termo a ser buscado no arquivo informado  
apagaLinhaSeExiste() {
	CAMINHO_ARQUIVO=$1
	TERMO_BUSCA=$2
    sed -i "/$TERMO_BUSCA/d" $CAMINHO_ARQUIVO
}

# Função responsável por apagar todo o easter egg do servidor web
# Apaga linhas e arquivos do easter egg
resetaEasterEgg() {
	rm -f "$CAMINHO_SITE/ovos.txt"
	rm -f "$CAMINHO_SITE/ovum.xml"
	rm -f "$CAMINHO_SITE/css/xml.css"
	rm -f "$CAMINHO_SITE/img/qr_code.svg"
	rm -f "$CAMINHO_SITE/宝.php"
	rm -f "$CAMINHO_SITE/img/ache_a_flag.jpg"
	ARQUIVO_RESPOSTA="Resposta_Desafio_`expr $QUANT_DESAFIOS + 1`"
	
	rm -f "$DESTINO_RESPOSTAS/$ARQUIVO_RESPOSTA"

	apagaLinhaSeExiste "$CAMINHO_SITE/index.php" "ovos"
	apagaLinhaSeExiste "$CAMINHO_SITE/home.php" "ovos"
	apagaLinhaSeExiste "$CAMINHO_SITE/404.php" "ovum"
	apagaLinhaSeExiste "$CAMINHO_SITE/img/logo.svg" "qr_code" 
}

# Função que adiciona as linhas e arquivos do Easter Egg ao servidor web
adicionaEasterEgg() {
	logger "Apagando arquivos e linhas do easter egg se existirem;"
	resetaEasterEgg

	logger "Adicionando linhas do easter egg nos respectivos arquivos;"
	CAMINHO_EASTER_EGG="../easterEgg"
	adicionaLinhaAposTermo "$CAMINHO_SITE/index.php" "</footer>" "<!-- ovos.txt -->"
	adicionaLinhaAposTermo "$CAMINHO_SITE/home.php" "</footer>" "<!-- ovos.txt -->"
	adicionaLinhaAposTermo "$CAMINHO_SITE/404.php" "icon" "<!-- <script src=\"ovum.xml\"></script> -->"
	adicionaLinhaAposTermo "$CAMINHO_SITE/img/logo.svg" "img-logo" "<!-- img/qr_code.svg -->"
	# adicionaLinhaAposTermo "$CAMINHO_SITE/home.php" "logo" "<!-- img/qr_code.svg -->"

	logger "Copiando os arquivos do easter egg para o servidor web;"
	cp "$CAMINHO_EASTER_EGG/ovos.txt" "$CAMINHO_SITE"
	cp "$CAMINHO_EASTER_EGG/ovum.xml" "$CAMINHO_SITE"	
	cp "$CAMINHO_EASTER_EGG/xml.css" "$CAMINHO_SITE/css"
	cp "$CAMINHO_EASTER_EGG/qr_code.svg" "$CAMINHO_SITE/img"	
	cp "$CAMINHO_EASTER_EGG/宝.php" "$CAMINHO_SITE"
	cp "$CAMINHO_EASTER_EGG/ache_a_flag.jpg" "$CAMINHO_SITE/img"
	
	ARQUIVO_RESPOSTA="Respostas_Desafio_`expr $QUANT_DESAFIOS + 1`"
	rm -f "$DESTINO_RESPOSTAS/$ARQUIVO_RESPOSTA"
	for i in $(seq $QUANT_JOGADORES); do
		echo "TreasureHunt{_OSU_}" >> "$DESTINO_RESPOSTAS/$ARQUIVO_RESPOSTA"
	done 
}

# Função que pergunta ao organizador se ele deseja adicionar o Easter Egg
# ao Jogo. Se sim, chama a função adicionaEasterEgg.
manejaAdicaoEasterEgg() {
	logger "Solicitando se usuário deseja adicionar o Easter Egg ao jogo;"
	while true; do
		echo -e "----------"
		echo "Deseja adicionar o Easter Egg ao Jogo?" 
		echo "O Easter Egg é um desafio adicional com dicas e pistas espalhadas pelo site, portanto não estará disponível nos arquivos dos jogadores."
		echo "A submissão da flag do Easter Egg deverá ser feita pela tela de submissão de flags."
		echo "A flag contabilizará como um desafio adicional, mas cabe aos jogadores descobrirem as dicas para resolver este desafio."
		echo "----------"
		echo "Lista de opções disponíveis: "
		echo "1: Adicionar Easter Egg."
		echo "2: Não adicionar o Easter Egg."
		echo "----------"
		read -p "Digite uma das opções acima: " OPCAO
		echo "----------"
		case $OPCAO in
			1|2) break ;; 
			*) echo -e "Opção inválida, digite novamente! " && sleep 1;;
		esac 
	done	

	if [ $OPCAO = "1" ]; then
		logger "O organizador desejou adicionar o Easter Egg à competição;"
		echo "Gerando Easter Egg..." && sleep 0.5
		adicionaEasterEgg
		return 0
	else
		echo "Prosseguindo sem adicionar o Easter Egg." && sleep 0.5
		resetaEasterEgg
		logger "O organizador desejou não adicionar o Easter Egg à competição;"
		return 1
	fi
}

# Ponto de partida do script
pegaCoresTerminal

echo "----------"
echo "Treasure Hunt!"
echo "----------"

# Garantindo que o diretório de trabalho é o diretório do script
cd $DIR_SCRIPT

altoContraste
excluiLogger
logger "Script iniciado;"

manejaArquivosCompeticoesAntigos 

# Variáveis que armazenarão nº de desafios e jogadores da competição

QUANT_DESAFIOS=0
QUANT_JOGADORES=0

LOCAL=0
obtemValor "DESAFIOS"
QUANT_DESAFIOS=$LOCAL
echo "----------"

logger "Usuário determinou que a competição terá $QUANT_DESAFIOS desafio(s);"

LOCAL=0
obtemValor "JOGADORES"
QUANT_JOGADORES=$LOCAL

logger "Usuário determinou que a competição terá $QUANT_JOGADORES jogador(es);"

manejaEscolhaDesafios
geraArquivosResposta

# Executa uma vez
verificaRespostas
if [ $? != "0" ]; then
	# Se deu errado é porque ele já recriou, então tentamos de novo
	# Se mesmo assim não der ele sai do script
	MSG_LOG="O erro persistiu mesmo depois de recriar a competição. Abortando Script."
	verificaRespostas 
	if [ $? != "0" ]; then 
		abortaScript $MSG_LOG
	fi
else 
	echo -e "Verificação concluída com sucesso!"
	logger "Sucesso: a quantidade de respostas coincide com o n° de jogadores;"
fi

compactaDesafios
manejaArquivosAtuais
enviaDesafiosCompactados

manejaAdicaoEasterEgg

ADICIONAR_EASTER_EGG=$?

# Se o seu MySQL estiver com senha, altere aqui com --password
sh ConfiguraBD.sh $QUANT_JOGADORES $QUANT_DESAFIOS $ADICIONAR_EASTER_EGG| mysql --user=root
logger "Banco de dados 'TreasureHunt' configurado;"
echo -e "Banco de dados configurado com sucesso."

logger "Fim da criação da competição;"
echo -e "Fim da criação da Competição."

manejaAtivacaoNgrok

logger "Script finalizado;"

criaLog

restauraCores
