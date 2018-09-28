# Recebe o diretório em que estão os arquivos que serão codificados com base64. Se não for indicado, pega o diretório atual.
if [ $# -eq 0 ]
then DIRETORIO="../$pwd/"
else DIRETORIO="$1"
fi

# Caminho do arquivo de saída
SAIDA=$2

# Cria a flag
FLAG="TreasureHunt{$(cat /dev/urandom | tr -cd 'a-z' | head -c 9)}"

while [ true ]
do
	# Se o script não for chamado com cinco parâmetros, sorteia um arquivo no diretório definido
	# Não funciona para arquivo com espaço em branco
	if [ $# -eq 5 ] && [ $4 -eq 1 ]
	then ARQUIVO=$5
	else
		ARQUIVO=$(ls "$DIRETORIO" | shuf -n 1)
		echo $ARQUIVO ####
		if [ ! $DIRETORIO = "/" ]
			# Copia o arquivo sorteado para o diretório do jogador
			then cp $DIRETORIO$ARQUIVO ${SAIDA}PROVISORIA
		fi
	fi

	# Volta ao laço se for um diretório; interrompe caso contrário
	[ -d "$DIRETORIO$ARQUIVO" ] || break
done

# Verifica se são 3 parâmetros e se o terceiro parâmetro é 1
# Este caso é para a execução do problema não-composto
case $3 in
	1|2)
	# Define (Q1;Q3) como intervalo no qual a flag poderá ser inserida
	MAXIMO=$(wc -l < $DIRETORIO$ARQUIVO)
	Q1=$(expr $MAXIMO / 4)
	Q3=$(( 3 * $MAXIMO / 4 ))

	# Sorteia uma linha do arquivo para inserir a flag
	LINHA_SORTEADA=$(shuf -i $Q1-$Q3 -n1)
	LINHA="$(head -n $LINHA_SORTEADA $DIRETORIO$ARQUIVO | tail -1)"

	# Verifica se a linha está vazia e insere a flag
	if [ -z "$LINHA" ]
	then sed -i -e "${LINHA_SORTEADA}s~^$~$LINHA $FLAG~g" "${SAIDA}PROVISORIA"
	else sed -i -e "${LINHA_SORTEADA}s~$~ $FLAG~" "${SAIDA}PROVISORIA"
	fi ;;
esac

# Codifica o arquivo sorteado em base64 (ou criptografa com Cifra de César) e redireciona o resultado para o arquivo de saída
case $3 in 
	0) base64 "$DIRETORIO$ARQUIVO" >> "$SAIDA" ;;
	1) base64 "${SAIDA}PROVISORIA" >> "$SAIDA" ;;
	2) cat "${SAIDA}PROVISORIA" | caesar $(seq 1 25 | shuf -n 1) >> "$SAIDA" ;;
	3) cat "$DIRETORIO$ARQUIVO" | caesar $(seq 1 25 | shuf -n 1) >> "$SAIDA" ;;
	4) echo $FLAG | base64 >> "$SAIDA" ;;
	5) echo $3; echo $FLAG | caesar $(seq 1 25 | shuf -n 1) >> "$SAIDA" ;;
esac

# Remove o arquivo copiado
rm -f ${SAIDA}PROVISORIA