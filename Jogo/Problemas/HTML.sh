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


ARQUIVOS_BASE="../HTML"

# Sorteia uma imagem
LINHA_SORTEADA=$(shuf -i 1-$(wc -l <$ARQUIVOS_BASE/imagens.txt) -n 1)

HASH_NO_ARQUIVO=`sed -n ${LINHA_SORTEADA}'p' < $ARQUIVOS_BASE/hash.txt` # retorna a linha do hash respectivo
IMAGEM=`sed -n ${LINHA_SORTEADA}'p' < $ARQUIVOS_BASE/imagens.txt` # retorna a linha com a url da imagem

HASH_IMAGEM=`curl -s $IMAGEM | sha256sum | head -c 65`

if [ $HASH_NO_ARQUIVO = $HASH_IMAGEM ]
then LEGENDA=`sed -n ${LINHA_SORTEADA}'p' < $ARQUIVOS_BASE/legendas.txt`
else LEGENDA="Pichação aleatória sem importância"
fi 

# shuf -i 1-$(wc -l <ARQUIVO_COM_LINKS_DE_IMGS.txt) -n 1
# IMAGEM=$(sort -R ../HTML/imagens.txt | shuf -n 1)''

# Coloca a imagem sorteada na tag de imagem no arquivo HTML
sed -i -e "s~\"\"~\"$IMAGEM\"~g" "$NOVO_ARQUIVO"

sed -i -e "s/Imagem do desafio/$LEGENDA/g" "$NOVO_ARQUIVO"

# Sorteia a cor do parágrafo
ESTILO=$(seq 999999 | shuf -n 1)

# Coloca o estilo sorteado no parágrafo
sed -i -e "s~<p>~<p style=\"color:#$ESTILO;\">~g" "$NOVO_ARQUIVO"

# Define que a flag deve estar entre as tags <body> e </body>
MINIMO=$(awk '/<body>/{ print NR; }' $NOVO_ARQUIVO)
MAXIMO=$(awk '/<\/body>/{ print NR; }' $NOVO_ARQUIVO)

# Sorteia uma linha do arquivo para inserir a flag
LINHA_SORTEADA_FLAG=$(shuf -i $MINIMO-$MAXIMO -n1)
LINHA=$(head -n $LINHA_SORTEADA_FLAG $NOVO_ARQUIVO | tail -1)

# Insere a flag na linha selecionada
sed -i -e "${LINHA_SORTEADA_FLAG}s~$~ <!-- $FLAG -->~" "$NOVO_ARQUIVO"


# se precisar gerar os hashes das imagens novamente
gerar_hashes() {
    rm -f hash.txt 
    touch hash.txt
    while read line; do 
        BLA=`curl -s $line | sha256sum | head -c 65`
        echo $BLA >> hash.txt
    done < imagens.txt
}
