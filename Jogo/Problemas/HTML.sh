# Define o nome do arquivo HTML
ARQUIVO=$1

# Trabalha em cima de uma cópia do arquivo
NOVO_ARQUIVO=$2

# Cria uma cópia do arquivo
cp $ARQUIVO $NOVO_ARQUIVO

# Define um nome aleatório para a flag (tamanho 12)
if [ $# -eq 3 ]
then FLAG=$(cat $3)
else FLAG="TreasureHunt{"$(cat /dev/urandom | tr -cd 'a-z0-9' | head -c 12)"}"
fi

# Sorteia o cabeçalho entre h1 e h6
TAMANHO_CABECALHO=$(seq 6 | shuf -n 1)

# Sorteia uma imagem
IMAGEM=$(sort -R ../HTML/imagens.txt | shuf -n 1)

# Coloca a imagem sorteada na tag de imagem no arquivo HTML
sed -i -e "s~\"\"~\"$IMAGEM\"~g" "$NOVO_ARQUIVO"

# Sorteia a cor do parágrafo
ESTILO=$(seq 999999 | shuf -n 1)

# Coloca o estilo sorteado no parágrafo
sed -i -e "s~<p>~<p style=\"color:#$ESTILO;\">~g" "$NOVO_ARQUIVO"

# Define que a flag deve estar entre as tags <body> e </body>
MINIMO=$(awk '/<body>/{ print NR; }' $NOVO_ARQUIVO)
MAXIMO=$(awk '/<\/body>/{ print NR; }' $NOVO_ARQUIVO)

# Sorteia uma linha do arquivo para inserir a flag
LINHA_SORTEADA=$(shuf -i $MINIMO-$MAXIMO -n1)
LINHA=$(head -n $LINHA_SORTEADA $NOVO_ARQUIVO | tail -1)

# Insere a flag na linha selecionada
sed -i -e "${LINHA_SORTEADA}s~$~ <!-- $FLAG -->~" "$NOVO_ARQUIVO"