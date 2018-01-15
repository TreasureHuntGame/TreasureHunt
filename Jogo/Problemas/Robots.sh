# Define a quantidade de palavras comentadas em cada arquivo
NUM_PALAVRAS=$1

# Define o diretório de origem do website
ORIGEM=$2

# Define o diretório de destino do website
DESTINO=$3

# Pega o nome do diretório em que o website está
DIRETORIO_FINAL=$(basename $ORIGEM)

# Copia o diretório para a pasta de cada instância do problema
cp -r $ORIGEM $DESTINO

# Copia o arquivo - que deve ser robots.txt - para o diretório que contém o website
cp $4 "$DESTINO/$DIRETORIO_FINAL"

# Armazena o número de linhas do arquivo (robots.txt)
NUM_LINHAS=$(wc -l < $4)

# Gera $NUM_PALAVRAS comentários aleatórios
for j in $(seq 1 $NUM_PALAVRAS)
do
	# A primeira palavra inserida no arquivo sempre será a flag
	if [ $j -eq 1 ]
	then
		if [ $# -eq 5 ]
		then PALAVRA=$(cat $5)
		else PALAVRA="TreasureHunt{$(cat /dev/urandom | tr -cd 'a-z0-9' | head -c 32)}"
		fi
	else  # Define uma palavra aleatória de tamanho 32
		PALAVRA=$(cat /dev/urandom | tr -cd 'a-z0-9' | head -c 32)
	fi

	# Sorteia uma linha do arquivo para inserir a flag
	LINHA_SORTEADA=$(seq $NUM_LINHAS | shuf -n 1)

	# Obtém o conteúdo da linha sorteada
	LINHA=$(sed "${LINHA_SORTEADA}q;d" $DESTINO/$DIRETORIO_FINAL/$(basename $4))

	# Teste para verificar se a linha está vazia
	if [ -z "$LINHA" ]
	then sed -i -e "${LINHA_SORTEADA}s~^$~\# $PALAVRA~g" "$DESTINO/$DIRETORIO_FINAL/$(basename $4)"
	else sed -i -e "${LINHA_SORTEADA}s~$~ \# $PALAVRA~" "$DESTINO/$DIRETORIO_FINAL/$(basename $4)"
	fi 
done