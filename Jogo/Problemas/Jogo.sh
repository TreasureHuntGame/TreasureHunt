#!/bin/bash

# Ao executar, certifique-se de que você está executando os serviços apache e mysql
# mysql deve estar rootado sem senha e as tabelas TreasureHunt.Usuario e TreasureHunt.Resposta, caso existam, serão esvaziadas

# Identificador do último problema
MAX=8

# Define o diretório que receberá os desafios
DESTINO_DESAFIOS="/var/www/html/TreasureHunt/Desafios/"

# Array que armazenará o identificador de cada problema
PROBLEMAS=

# Função que verifica se o parâmetor informado é positivo.
obterValor() {
	while [ $LOCAL -le 0 ]
	do
		read -p "Informe a quantidade de $1: " LOCAL
	done
}

# Função que verifica se o parâmetro informado é válido
verificaParametro() {
	# Verifica se o valor é válido (entre 1 e 8).
	case $1 in
		1|2|3|4|5|6|7|8) ;;
		*) erroParametro ;;
	esac
}

# Função que verifica se a composição informada é válida
verificaComposicao() {
	case $PROBLEMA1 in
		# O problema 1 pode ser composto com todos os problemas
		# O problema 2 pode ser composto com todos, exceto
		# com os problemas 2 e 5
		# O problema 5 pode ser composto com todos, exceto
		# com o problema 2
		1|2|5) 
		case $PROBLEMA2 in
			1|3|4|6|7|8) ;;
			*)
			if ([ $PROBLEMA1 -eq  1 ] && ([ $PROBLEMA2 -eq 2 ] || [ $PROBLEMA2 -eq 5 ])) || ([ $PROBLEMA1 -eq 5 ] && [ $PROBLEMA2 -eq 5 ])
				then LOCK=0
				else LOCK=1
			fi ;;
		esac ;;
		# Os problemas 3, 4, 6, 7 e 8 são compostos
		# somente com os problemas 1, 2, 5 e 8
		3|4|6|7|8)
		case $PROBLEMA2 in
			1|2|5|8) ;;
			*) LOCK=1 ;;
		esac ;;
	esac

	# Se a variável LOCK = 1, então tem-se um erro de composição
	if [ $LOCK -eq 1 ]
	then erroComposicao
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
erroParametro () {
	echo "----------"
	echo "O(s) parâmetro(s) deve(m) estar entre 1 e $MAX."
	echo "----------"
	LOCK=1
}

# Função de erro na quantidade de parâmetros
erroNumParametros () {
	echo "----------"
	echo "O programa só aceita 1 ou 2 parâmetros."
	echo "Sintaxe: A [B]"
	echo "onde A e B são os identificadores dos problemas."
	echo "----------"
	LOCK=1
}

# Função de erro de composição inválida ou inexistente
erroComposicao () {
	echo "----------"
	echo "Composição inválida ou inexistente."
	echo "----------"
	LOCK=1
}


# verifica se existe um Log já criado
# se existe retorna 0 
existeLog () {
	[ -f "Log" ] && return 0
}

# verifica se existe algum diretório numérico
# se existir algum retorna 0
existeDirNumericos () {
	for d in ../*; do 
        f=`echo $d | cut -b 4-`
        [[ $f =~ ^[0-9]+$ ]] && return 0
    done 
}

# verifica se existe arquivo de resposta
# se existir retorna 0
existeRespostas () {
	mkdir -p ../Respostas
    for f in ../Respostas/*; do 
        [ -s $f ] && return 0    
    done  
}

existeZip () {
	for f in ../../TreasureHunt/Desafios/*; do 
        [ -s $f ] && return 0
	done
}

# Função que cria o log do jogo
criarLog () {
	NOME_LOG="Log"
	IDC=`date +%d/%m/%Y_%H:%M:%S`
	echo "---------- BEGIN TH{LOG} ----------" > $NOME_LOG
	echo "IDC: Competição_$IDC  " >> $NOME_LOG
	echo "QUANT_DESAFIOS: $QUANT_DESAFIOS" >> $NOME_LOG
	echo "QUANT_JOGADORES: $QUANT_JOGADORES" >> $NOME_LOG
	for (( i=1; i<=$QUANT_DESAFIOS; i++ )); do
		echo "Desafio $i: ${LISTA_DESAFIOS[$i-1]}" >> $NOME_LOG
	done 
	echo -e "---------- Log Detalhado ----------" >> $NOME_LOG
	cat Logger >> Log 
	echo "---------- END TH{LOG} ----------" >> $NOME_LOG
	rm -f Logger 
}

# move os arquivos de log, diretórios numéricos, respostas e zips
# para um diretório nomeado com timestamp 
moverArquivosCompeticoes () {
	echo -e "\n\nMovendo arquivos para o diretório OLD" && sleep 1
	TS=`date +%d-%m-%y_%H-%M-%S`
	OLD_DIR="../OLD_$TS"
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
	if existeRespostas; then #move as respostas
		cp -r ../Respostas $OLD_DIR && rm -rf ../Respostas   
		mkdir -p ../Respostas/
	fi 

	if existeZip; then #move os zips
		for f in ../../TreasureHunt/Desafios/*; do 
			rm -f $f 
		done
	fi
	logger "Usuário escolheu mover os arquivos de competições anteriores para o diretórito $OLD_DIR"
	echo "----------"
}

# exclui os arquivos de log, diretórios numéricos, respostas e zips
excluirArquivosCompeticao () {
	echo -e "\n\nRemovendo arquivos\n"  && sleep 1
	existeLog && rm -f Log # apagar log
	if existeRespostas; then # apagar respostas
		rm -rf ../Respostas 
		mkdir -p ../Respostas/ 
	fi
	for d in ../*; do  # apagar diretórios numéricos
		f=`echo $d | cut -b 4-`
		if [[ $f =~ ^[0-9]+$ ]]; then 
			rm -rf $d 		
		fi  
	done 
	if existeZip; then # apagar zips
		for f in ../../TreasureHunt/Desafios/*; do 
			rm -f $f 
		done
	fi 
	logger "Usuário escolheu excluir arquivos de competições anteriores"
	echo "----------"
}

# aborta script 
abortarScript () {
	echo -e "\n\nAbortando o script! \n"  && sleep 1
	logger "Usuário escolheu abortar script"
	exit 1
}

# verifica se existe algum arquivo de competição antigo. 
# Se existir pergunta ao usuário o que ele deseja fazer
manejarArquivosCompeticoesAntigos () {
	# se algum arquivo de outra competição já estiver criado 
	if existeLog || existeDirNumericos || existeRespostas; then
		logger "Arquivos de competições anteriores foram encontrados"
		while true; do  # pergunta o que o usuário deseja fazer
			echo -e "\nArquivos de competições anteriores foram encontrados! "
			read -p "Você deseja movê-los [1], excluí-los [2] ou abortar o script [3]? [1,2,3]: " OPCAO
			case $OPCAO in 
				1|2|3) break;;
				*) echo "Opção inválida, digite novamente! " && sleep 1;;
			esac 
		done

		if [ $OPCAO = "1" ]; then  # se escolher 1, move tudo para a pasta OLD
			moverArquivosCompeticoes

		elif [ $OPCAO = "2" ]; then # se escolher 2, exclui os arquivos
			excluirArquivosCompeticao

		elif [ $OPCAO = "3" ]; then # se escolher 3, sai do script
			abortarScript
		fi    
	fi 
}

# função que loga detalhadamente 
# $1 mensagem
logger () {
	[ ! -f Logger ] && touch Logger
	ts=`date +%d-%m-%y_%H-%M-%S`
	echo "$ts: $1" >> Logger
}

echo "----------"
echo "Treasure Hunt!"
echo "----------"

logger "Script iniciado"

manejarArquivosCompeticoesAntigos 

# Variáveis que armazenarão nº de desafios e jogadores da competição
QUANT_DESAFIOS=0
QUANT_JOGADORES=0

LOCAL=0
obterValor "DESAFIOS"
QUANT_DESAFIOS=$LOCAL

logger "Usuário determinou que a competição terá $QUANT_DESAFIOS desafio(s)"

LOCAL=0
obterValor "JOGADORES"
QUANT_JOGADORES=$LOCAL

logger "Usuário determinou que a competição terá $QUANT_JOGADORES jogador(es)"

LISTA_DESAFIOS=()

echo "----------"
echo "Vamos criar os desafios!"
echo "----------"

logger "Iniciado criação de desafios"
for i in $(seq $QUANT_DESAFIOS)
do
	LOCK=1

	while [ $LOCK -eq 1 ]
	do
		echo "Lista de problemas disponíveis:"
		echo "1: (De)codificação de arquivo em base64"
		echo "2: (Des)criptografia de Cifra de César"
		echo "3: Comentário em código-fonte de página HTML"
		echo "4: Comentário no arquivo robots.txt"
		echo "5: (De)codificação de caractere ASCII para inteiro"
		echo "6: Descompilar binário e obter fonte Java"
		echo "7: Descompilar binário e obter fonte Python"
		echo "8: Esteganografia em imagens"
		echo "Obs.: escolha 1 ou 2 problemas. Exibiremos uma mensagem de erro se a composição não existir."
		echo "----------"

		read -p "Informe o(s) problema(s) do desafio $i: " PROBLEMA1 PROBLEMA2
		DESAFIO_ATUAL="$PROBLEMA1 $PROBLEMA2"
		verificaParametros $PROBLEMA1 $PROBLEMA2

		logger "Desafio $DESAFIO_ATUAL adicionado a competição"
		LISTA_DESAFIOS+=("$DESAFIO_ATUAL")

		if [ $LOCK -eq 0 ]
		then
			sh Composer.sh $QUANT_JOGADORES $i $PROBLEMA1 $PROBLEMA2
			PROBLEMAS[$i]=$PROBLEMA1$PROBLEMA2
		fi
	done

	echo "----------"
	echo "Problema gerado!"
	echo "----------"
done

echo "Obtendo as soluções..."
logger "Obtenção das soluções dos desafios..."
# Caso não exista, cria o diretório que conterá as respostas
mkdir -p ../Respostas/

for i in $(seq $QUANT_DESAFIOS)
do
	sh "../Solucoes/sol${PROBLEMAS[$i]}.sh" $QUANT_JOGADORES $i > "../Respostas/Respostas_Desafio_$i"
	echo "Resposta(s) do desafio $i gerada(s) em Respostas_Desafio_$i (diretório Respostas)."
	dir=`readlink -f ../Respostas`
	logger "Resposta(s) do desafio $i gerada(s) em Respostas_Desafio_$i ($dir)."
done

# Comprime os desafios do jogador em um arquivo zip
for i in $(seq $QUANT_JOGADORES)
do
 	zip -r -q "../Jogador$i.zip" "../$i/"
	logger "Compressão do arquivo do jogador $i (Jogador$i.zip)"
done

# Se o usuário teclar 1, mantém os arquivos originais. Caso contrário exclui as pastas dos jogadores
read -p "Deseja manter os arquivos originais? (Tecle <ENTER> para SIM) " RESOLVER

if [ ! $RESOLVER = "" ]; then
	logger "Usuário decidiu excluir arquivos originais"
	for i in $(seq $QUANT_JOGADORES)
	do
		echo "Removendo o diretório do jogador $i."
		rm -rf "../$i/"
		logger "Removendo o diretório do jogador $i."
	done
else 
	logger "Usuário decidiu manter arquivos originais"
fi

mkdir -p $DESTINO_DESAFIOS
for i in $(seq $QUANT_JOGADORES)
do
	mv "../Jogador$i.zip" $DESTINO_DESAFIOS
	dir=`readlink -f $DESTINO_DESAFIOS`
	logger "Jogador$i.zip enviado para diretório Desafios ($dir)"
done

# Se o seu mysql estiver com senha, altere aqui com --password
sh ConfiguraBD.sh $QUANT_JOGADORES $QUANT_DESAFIOS | mysql --user=root
logger "Banco de dados 'TreasureHunt' configurado"

logger "Script finalizado"

criarLog 
