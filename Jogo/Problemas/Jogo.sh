#!/bin/bash

# Ao executar, certifique-se de que você está executando os serviços apache e mysql
# mysql deve estar rootado sem senha e as tabelas TreasureHunt.user e TreasureHunt.Resposta, caso existam, serão esvaziadas

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

# Variáveis que armazenarão nº de desafios e jogadores da competição
QUANT_DESAFIOS=0
QUANT_JOGADORES=0

echo "----------"
echo "Treasure Hunt!"
echo "----------"

echo "---------- BEGIN TH{LOG} ----------" > Log
echo "IDC: " >> Log

LOCAL=0
obterValor "DESAFIOS"
QUANT_DESAFIOS=$LOCAL

LOCAL=0
obterValor "JOGADORES"
QUANT_JOGADORES=$LOCAL

echo "QUANT_DESAFIOS: $QUANT_DESAFIOS" >> Log
echo "QUANT_JOGADORES: $QUANT_JOGADORES" >> Log

echo "----------"
echo "Vamos criar os desafios!"
echo "----------"

for i in $(seq $QUANT_DESAFIOS)
do
	LOCK=1

	while [ $LOCK -eq 1 ]
	do
		echo "Lista de problemas disponíveis:"
		echo "1: base64"
		echo "2: César"
		echo "3: Comentário em código HTML"
		echo "4: Comentário em robots.txt"
		echo "5: Conversão para sequência de inteiros"
		echo "6: Descompilar .class"
		echo "7: Descompilar .pyc"
		echo "8: Esteganografia em imagens"
		echo "Obs.: escolha 1 ou 2 problemas. Exibiremos uma mensagem de erro se a composição não existir."
		echo "----------"

		read -p "Informe o(s) problema(s) do desafio $i: " PROBLEMA1 PROBLEMA2
		verificaParametros $PROBLEMA1 $PROBLEMA2

		echo "Desafio $i: $PROBLEMA1 $PROBLEMA2" >> Log

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
# Caso não exista, cria o diretório que conterá as respostas
mkdir -p ../Respostas/
for i in $(seq $QUANT_DESAFIOS)
do
	sh "../Solucoes/sol${PROBLEMAS[$i]}.sh" $QUANT_JOGADORES $i > "../Respostas/Respostas_Desafio_$i"
	echo "Resposta(s) do desafio $i gerada(s) em Respostas_Desafio_$i (diretório Respostas)."
done

# Comprime os desafios do jogador em um arquivo zip
for i in $(seq $QUANT_JOGADORES)
do
 	zip -r -q "../Jogador$i.zip" "../$i/"
done

# Se o usuário teclar 1, mantém os arquivos originais. Caso contrário exclui as pastas dos jogadores
read -p "Deseja manter os arquivos originais? (Tecle <ENTER> para SIM) " RESOLVER

if [ ! $RESOLVER = "" ]
then
	for i in $(seq $QUANT_JOGADORES)
	do
		echo "Removendo o diretório do jogador $i."
		rm -rf "../$i/"
	done
fi

mkdir -p $DESTINO_DESAFIOS
for i in $(seq $QUANT_JOGADORES)
do
	mv "../Jogador$i.zip" $DESTINO_DESAFIOS
done

# Se o seu mysql estiver com senha, altere aqui com --password
sh ConfiguraBD.sh $QUANT_JOGADORES $QUANT_DESAFIOS | mysql --user=root

echo "---------- END TH{LOG} ----------" >> Log