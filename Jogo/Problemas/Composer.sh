# 1: base64
# 2: César
# 3: Comentário em código HTML
# 4: Comentário em robots.txt
# 5: Conversão para sequência de inteiros
# 6: Descompilar .class
# 7: Descompilar .pyc
# 8: Esteganografia em imagens
# 9: base32

# Define a geração de $NUM_INSTANCIAS instâncias
NUM_INSTANCIAS="$1"

# Define a quantidade de desafios
NUM_DESAFIO="$2"

# Obtém o código do problema 1
PROBLEMA1="$3"

# Obtém o código do problema 2
PROBLEMA2="$4"

# Define o diretório que contém o website utilizado no problema Robots
ORIGEM="../Site/ATP"
ORIGEM2=$(echo "$ORIGEM" | cut -c 3-)

# Define o diretório padrão para obter as imagens
# Há problemas que permitem imagens de tamanhos aleatórios,
# mas outros precisam de imagens grandes
FONTEIMAGENS="../Imagens/"

# Define o diretório padrão para obter as imagens quando
# um problema de esteganografia é composto com outro
FONTEIMAGENS2="../Imagens/"

# Define o diretório padrão para obter arquivos utilizados
# no desafio HTML
FONTEHTML="../HTML/"

# Define o diretório padrão para obter arquivos utilizados
# no desafio Robots
FONTEROBOTS="../Robots/"

# Define o nome do arquivo utilizado como entrada para problemas
# Valor padrão definido para entrada dos problemas 1, 2 e 9
ENTRADA="saidao.out"

# Define o nome de outro arquivo utilizado como entrada para problemas
# Valor padrão definido para entrada dos problemas 1, 2 e 9
ENTRADA2="saida.out"

# Define o valor do parâmetro padrão para os problemas
# base64, caesar ou base32. Valor padrão zero indica problema base64
PARAM1=0

# Define o valor de um segundo parâmetro para os problemas base64, caesar
# ou base32 compostos. 1 é o valor usado pela composição 1 1
PARAM2=1

# Define o valor de um parâmetro extra utilizado no problema compos-
# to Robots + (base64 || caesar || base32). Neste caso ele é setado como 1
PARAM3=0

# Define o quarto parâmetro do problema
# Valor padrão definido para entrada dos problemas 1, 2 e 9
PARAM4="../Textos/"

# Define a linguagem chamada para o desafio de Descompilar código
# Valor padrão definido em 1 para a linguagem Java. Python = 2
LINGUAGEM=1

# Função que executa o problema 3, 6, 7 ou 8
# composto com o problema 1, 2, 5, 8 ou 9
criaProblema () {
	case $PROBLEMA2 in
		# Se o segundo problema é o problema 2 (césar), utiliza PARAM1 = 2
		# Exceto se PROBLEMA1 = 1 ou PROBLEMA1 = 9
		1) PARAM2=$PROBLEMA1 ;;
		# Se o segundo problema é o problema 2 (césar), utiliza PARAM1 = 3
		2)
		PARAM1=3
		PARAM2=$PROBLEMA1 ;;
		# Se o primeiro problema é 2 e o segundo é 3, 4, 6, 7 ou 8,
		# então PARAM2 = 5; caso o primeiro problema seja 1, PARAM2 = 4,
		# e se for o problema 9 (base32), PARAM2 = 8
		3|4|6|7|8)
		if [ $PROBLEMA1 -eq 2 ]
		then PARAM2=5
		else
			if [ $PROBLEMA1 -eq 1 ] 
			then PARAM2=4
			else PARAM2=8
			fi
		fi ;;
		# Se o segundo problema for o problema 5 (asc), utiliza PARAM2 = 8
		5) 
		if [ $PROBLEMA1 -eq 9 ]
		then PARAM2=8
		fi ;;
		# Se o segundo problema é o problema 9 (base32), utiliza PARAM1 = 6
		9)
		PARAM1=6
		PARAM2=$PROBLEMA1 ;;
	esac

	case $PROBLEMA1 in
		6|7|8) BINARIO=1 ;;
	esac

	for i in $(seq $NUM_INSTANCIAS)
	do
		# Cria um diretório para cada instância
		mkdir -p "../$i/$NUM_DESAFIO/"
		DESTINO="../$i/$NUM_DESAFIO/"

		case $PROBLEMA1 in
			1|9)
			if [ $PROBLEMA2 -eq 1 ] || [ $PROBLEMA2 -eq 2 ] || [ $PROBLEMA2 -eq 5 ] || [ $PROBLEMA2 -eq 9 ]
				then DESTINO="$3"
				else DESTINO="/"
			fi
			# Executa o problema BaseOuCaesar para base64
			sh BaseOuCaesar.sh $DESTINO "../$i/$NUM_DESAFIO/$1" $PARAM2
			# Diretório de destino passa a ser $i para
			# realizar as composições
			DESTINO="../$i/$NUM_DESAFIO/" ;;
			# Executa o problema BaseOuCaesar para Caesar
			2) sh BaseOuCaesar.sh $3 "../$i/$NUM_DESAFIO/$1" $PARAM2 ;;
			# Executa o problema Comentário em código HTML
			3) sh HTML.sh "$FONTEHTML$ENTRADA" $DESTINO$1 ;;
			# Define os diretórios e executa o problema Robots
			4) DESTINO="../$i/$NUM_DESAFIO/Site"
			mkdir -p $DESTINO
			sh Robots.sh 5 $ORIGEM $DESTINO "$FONTEROBOTS$ENTRADA"
			DESTINO="../$i/$NUM_DESAFIO/$ORIGEM2/"
			PARAM3=1 ;;
			# Executa o problema ToInt
			5) bash ToInt.sh $DESTINO$1 ;;
			# Executa o problema Descompilar Java ou Python
			6|7) sh BinToSource.sh $3 $DESTINO $LINGUAGEM ;;
			# Executa o problema Esteganografia
			8) # $i = SENHA PADRÃO. $SENHA1 é a variável de controle para saber se haverá senha
				sh Esteganografia.sh $3 $DESTINO$1 $i $SENHA1 ;;
			#9) # Executa o problema BaseOuCaesar para base32
			#sh BaseOuCaesar.sh $DESTINO "../$i/$NUM_DESAFIO/$1" $PARAM2 ;; 
			# Diretório de destino passa a ser $i para
			# realizar as composições
			# DESTINO="../$i/$NUM_DESAFIO/" ;; 
		esac

		case $PROBLEMA2 in
			3) ENTRADA2="index.html" ;;
			4) ENTRADA2="robots.txt" ;;
			6) PARAM4="../Java/" 
			   LINGUAGEM=1 ;;
			7) PARAM4="../Python/"
			   LINGUAGEM=2 ;;
			8) ENTRADA2="ronald.jpg" ;;
		esac

		case $PROBLEMA2 in
			1|2|9) 
			sh BaseOuCaesar.sh $DESTINO ${DESTINO}$ENTRADA2 $PARAM1 $PARAM3 $ENTRADA ;; 
			3) sh HTML.sh "$FONTEHTML$ENTRADA2" ${DESTINO}$ENTRADA2 ${DESTINO}$1 ;;			
			4) DESTINO2="../$i/$NUM_DESAFIO/Site"
			mkdir -p $DESTINO2
			sh Robots.sh 5 $ORIGEM $DESTINO2 "$FONTEROBOTS$ENTRADA2" $DESTINO$1 ;;
			5) bash ToInt.sh ${DESTINO}$ENTRADA2 $DESTINO$1 $BINARIO ;;
			6|7) sh BinToSource.sh $PARAM4 $DESTINO $LINGUAGEM $DESTINO$1 ;;
			8) # $i = SENHA PADRÃO. $SENHA2 é a variável de controle para saber se haverá senha
				sh Esteganografia.sh $2 ${DESTINO}$ENTRADA2 $DESTINO$1 $i $SENHA2 ;;
		esac

		# Apaga o arquivo de entrada
		rm $DESTINO$1

		if [ $PROBLEMA1 -eq 4 ]
			then mv "../$i/$NUM_DESAFIO/$ORIGEM2/$ENTRADA2" "../$i/$NUM_DESAFIO/$ORIGEM2/$ENTRADA"
		fi
	done	
}

########## Ponto de partida do programa ##########

# Define parâmetros com base no identificador dos problemas
case $PROBLEMA1 in
	3) ENTRADA="index.html" ;;
	4) ENTRADA="robots.txt"
	PARAM4=0 ;;
	5) ENTRADA="dados.dat" ;;
	6) ENTRADA="Desafio.class"
	PARAM4="../Java/" ;;
	7) ENTRADA="Desafio.pyc"
	PARAM4="../Python/"
	LINGUAGEM=2 ;;
	8) ENTRADA="ronald.jpg"
	PARAM4="../Imagens/"
	case $PROBLEMA2 in
	 	5|8) PARAM4="../ImagensPequenas/" ;;
	esac
	case $# in
	 	4) ENTRADA="ronaldo.jpg" ;;
	esac ;;
esac

if [ $PROBLEMA1 -eq 8 ]
then
	read -p "Deseja usar senha no Problema1, de esteganografia? [1 para 'sim']: " SENHA1
	if [ -z "$SENHA1" ]
	then SENHA1=0
	fi
fi

# Se um problema é informado, executa um dos 9 problemas individuais
case $# in
	3)
	for i in $(seq $NUM_INSTANCIAS)
	do
		mkdir -p "../$i/$NUM_DESAFIO/"
		case $PROBLEMA1 in
			1|2|9) sh BaseOuCaesar.sh $PARAM4 "../$i/$NUM_DESAFIO/$ENTRADA2" $PROBLEMA1 ;;
			3) sh HTML.sh "$FONTEHTML$ENTRADA" "../$i/$NUM_DESAFIO/$ENTRADA" ;;
			4) DESTINO="../$i/$NUM_DESAFIO/Site"
			mkdir -p $DESTINO
			sh Robots.sh 5 $ORIGEM $DESTINO "$FONTEROBOTS$ENTRADA" ;;
			5) bash ToInt.sh "../$i/$NUM_DESAFIO/$ENTRADA" ;;
			6|7) sh BinToSource.sh $PARAM4 "../$i/$NUM_DESAFIO/" $LINGUAGEM ;;
			8) # $i = SENHA PADRÃO. $SENHA1 é a variável de controle para saber se haverá senha
				sh Esteganografia.sh $FONTEIMAGENS "../$i/$NUM_DESAFIO/$ENTRADA" $i $SENHA1 ;;
		esac
	done ;;
	4)
	if [ $PROBLEMA2 -eq 8 ]
	then
		read -p "Deseja usar senha no Problema2, de esteganografia? [1 para 'sim']: " SENHA2
		if [ -z "$SENHA2" ]
		then SENHA2=0
		fi
	fi

	case $PROBLEMA1 in
		3|4|8) FONTEIMAGENS="../ImagensGrandes/" ;;
	esac
	# Chama a função que executa o desafio composto
	criaProblema $ENTRADA $FONTEIMAGENS $PARAM4 ;;
esac