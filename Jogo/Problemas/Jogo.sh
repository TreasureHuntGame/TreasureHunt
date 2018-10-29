# Ao executar, certifique-se de que você está executando os serviços apache e mysql
# mysql deve estar rootado sem senha e as tabelas TreasureHunt.Usuario e TreasureHunt.Resposta, caso existam, serão esvaziadas

# Identificador do último problema
MAX=9

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


verificaRespostas() {
	# Verifica se o diretório dos arquivos de respostas contém
	# 1) a quantidade correta de arquivos de resposta
	# 2) a quantidade de respostas correta em cada arquivo
	# 3) todas as respostas contém TreasureHunt

	# Verifica (1)
	QUANT_ARQUIVOS=$(expr $(ls -l "../Respostas/" | wc -l) - 1)
	echo "Foram encontrados $QUANT_ARQUIVOS arquivos. "
	if [ $QUANT_ARQUIVOS -ne $QUANT_DESAFIOS ]
	then
		echo "Eram necessários $QUANT_DESAFIOS."
	fi

	# Verifica (2) e (3)
	for i in $(seq $QUANT_DESAFIOS)
	do
		# Verifica (2)
		LINHAS_ARQUIVO=$(cat "../Respostas/Respostas_Desafio_$i" | wc -l)
		echo "Problema $i: $LINHAS_ARQUIVO respostas encontradas. "
		if [ $LINHAS_ARQUIVO -ne $QUANT_JOGADORES ]
		then echo "ERRO na linha anterior!"
		fi

		# Verifica (3)
		QUANT_RESPOSTAS_PADRAO=$(grep -c "TreasureHunt" "../Respostas/Respostas_Desafio_$i")
		echo "O arquivo contém $QUANT_RESPOSTAS_PADRAO respostas com o texto TreasureHunt. "
		if [ $QUANT_RESPOSTAS_PADRAO -ne $LINHAS_ARQUIVO ]
		then echo "ERRO na linha anterior!"
		fi
	done
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
echo "IDC: $(date)" >> Log

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
		echo "1: (De)codificação de arquivo em base64"
		echo "2: (Des)criptografia de Cifra de César"
		echo "3: Comentário em código-fonte de página HTML"
		echo "4: Comentário no arquivo robots.txt"
		echo "5: (De)codificação de caractere ASCII para inteiro"
		echo "6: Descompilar binário e obter fonte Java"
		echo "7: Descompilar binário e obter fonte Python"
		echo "8: Esteganografia em imagens"
		echo "9: (De)codificação de arquivo em base32"
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

#verificaRespostas >> Log
verificaRespostas | tee -a Log

echo "---------- END TH{LOG} ----------" >> Log