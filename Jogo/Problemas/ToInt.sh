#!/bin/bash
SAIDA=$1

case $# in
	# Caso para o problema individual ou primário
	1) # Define o tamanho do texto aleatório (sem a flag)
	TAM=120

	# Define o tamanho da flag
	TAM_FLAG=6

	# Define o intervalo em que a flag estará
	MEIO=$(expr $TAM / 2)
	MAXIMO=$(expr $MEIO + $MEIO / 2)
	MINIMO=$(expr $MAXIMO - $MEIO)

	# Se houver somente um argumento, define um texto aleatório de tamanho TAM
	TEXTO=$(cat /dev/urandom | tr -cd "[:graph:]" | head -c $TAM)

	# Define uma palavra aleatória de tamanho TAM_FLAG que será a flag
	FLAG="TreasureHunt{$(cat /dev/urandom | tr -cd 'A-Za-z0-9' | head -c $TAM_FLAG)}"

	# Define a posição em que a flag será inserida
	POSICAO_FLAG=$(seq $MINIMO $MAXIMO | shuf -n 1)

	# Insere a flag no texto aleatório
	TEXTO=${TEXTO:MINIMO:POSICAO_FLAG}$FLAG${TEXTO:POSICAO_FLAG:MAXIMO} ;;
  	
  	# Caso para composição com problemas que geram arquivos de texto
  	2) TEXTO=$(cat $2) ;;

	# Caso para composição com problemas que geram arquivos binários
	3) xxd -p $2 | sed 's/.\{2\}/& /g' | sed 's/[^ ]* */0x&/g' | awk '{ for(i=1;i<=NF;i++) printf("%i ",strtonum($i)); print ""; }' > $1 ;;
esac

# Converte o texto para decimal e salva no arquivo $SAIDA
case $# in
	1|2) 
	TOTAL_CARACTERES=$(echo ${#TEXTO} - 1 | bc);
	for j in $(seq 0 $TOTAL_CARACTERES)
	do printf "%d " "'${TEXTO:j:1}" >> $SAIDA
	done ;;
esac